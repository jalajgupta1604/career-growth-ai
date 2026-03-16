class SkillTrendImporterService
  SKILL_SOURCES = %w[naukri linkedin indeed].freeze

  def self.import_all
    new.import
  end

  def import
    skills_data = fetch_from_job_postings
    skills_data.each do |skill_name, data|
      trend = SkillTrend.find_or_initialize_by(name: skill_name)
      trend.update!(
        demand_score: data[:demand],
        growth_rate: data[:growth],
        avg_salary_impact: data[:salary_impact],
        category: data[:category],
        source: "platform_jobs"
      )
    end
  end

  private

  def fetch_from_job_postings
    results = {}

    active_jobs = JobPosting.active_listings.where("created_at > ?", 90.days.ago)
    return results if active_jobs.empty?

    skill_mentions = extract_skills_from_jobs(active_jobs)
    total_jobs = active_jobs.count.to_f

    previous_jobs = JobPosting.where(created_at: 180.days.ago..90.days.ago)
    previous_mentions = extract_skills_from_jobs(previous_jobs)
    prev_total = [previous_jobs.count.to_f, 1].max

    skill_mentions.each do |skill, count|
      current_pct = count / total_jobs * 100
      previous_pct = (previous_mentions[skill] || 0) / prev_total * 100
      growth = previous_pct > 0 ? ((current_pct - previous_pct) / previous_pct * 100).round(1) : 0

      results[skill] = {
        demand: (current_pct * 10).round(1).clamp(0, 100),
        growth: growth,
        salary_impact: estimate_salary_impact(skill),
        category: categorize_skill(skill)
      }
    end

    results
  end

  def extract_skills_from_jobs(jobs)
    skills = Hash.new(0)
    common_skills = %w[python javascript java ruby react node aws docker kubernetes sql
                       golang typescript rust flutter swift kotlin tensorflow pytorch
                       react-native angular vue redis mongodb postgresql kafka
                       terraform jenkins github-actions microservices graphql]

    jobs.find_each do |job|
      text = "#{job.title} #{job.description} #{job.requirements}".downcase
      common_skills.each do |skill|
        skills[skill] += 1 if text.include?(skill)
      end
    end

    skills.select { |_, count| count >= 2 }
  end

  def estimate_salary_impact(skill)
    high_value = %w[kubernetes golang rust tensorflow pytorch kafka terraform aws]
    medium_value = %w[react typescript docker redis mongodb graphql microservices]

    if high_value.include?(skill) then rand(15..25)
    elsif medium_value.include?(skill) then rand(8..15)
    else rand(3..8)
    end
  end

  def categorize_skill(skill)
    categories = {
      "languages" => %w[python javascript java ruby golang typescript rust swift kotlin],
      "frameworks" => %w[react angular vue flutter react-native node],
      "devops" => %w[docker kubernetes terraform jenkins github-actions aws],
      "data" => %w[sql mongodb postgresql redis kafka tensorflow pytorch],
      "architecture" => %w[microservices graphql]
    }

    categories.each do |cat, skills|
      return cat if skills.include?(skill)
    end
    "other"
  end
end
