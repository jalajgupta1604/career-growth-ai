class PeerBenchmarkService
  def initialize(user)
    @user = user
  end

  def generate
    peers = find_peers
    return nil if peers.count < 2

    salary_pct = calculate_salary_percentile(peers)
    skill_pct = calculate_skill_percentile(peers)
    interview_pct = calculate_interview_percentile(peers)

    @user.peer_benchmarks.create!(
      salary_percentile: salary_pct,
      skill_percentile: skill_pct,
      interview_percentile: interview_pct,
      peer_count: peers.count,
      peer_distribution: build_distribution(peers),
      comparison_data: build_comparison(peers, salary_pct, skill_pct, interview_pct),
      ranking_data: build_ranking(peers)
    )
  end

  def latest
    @user.peer_benchmarks.recent.first
  end

  private

  def find_peers
    User.where(role: @user.role)
        .where.not(id: @user.id)
        .where.not(current_salary: nil)
        .where.not(experience_years: nil)
  end

  def calculate_salary_percentile(peers)
    salaries = peers.pluck(:current_salary).map(&:to_f).sort
    return 50.0 if salaries.empty?

    below = salaries.count { |s| s < @user.current_salary.to_f }
    (below.to_f / salaries.size * 100).round(1)
  end

  def calculate_skill_percentile(peers)
    user_skills = latest_resume_skills(@user)
    return 50.0 if user_skills.empty?

    user_count = user_skills.size
    peer_counts = peers.joins(:resumes)
                       .where(resumes: { parsing_status: 2 })
                       .distinct
                       .map { |p| latest_resume_skills(p).size }

    return 50.0 if peer_counts.empty?

    below = peer_counts.count { |c| c < user_count }
    (below.to_f / peer_counts.size * 100).round(1)
  end

  def calculate_interview_percentile(peers)
    user_score = @user.career_reports.order(created_at: :desc).first&.interview_score.to_f
    return 50.0 if user_score.zero?

    peer_scores = peers.joins(:career_reports)
                       .distinct
                       .map { |p| p.career_reports.order(created_at: :desc).first&.interview_score.to_f }
                       .reject(&:zero?)

    return 50.0 if peer_scores.empty?

    below = peer_scores.count { |s| s < user_score }
    (below.to_f / peer_scores.size * 100).round(1)
  end

  def build_distribution(peers)
    all_salaries = (peers.pluck(:current_salary) + [@user.current_salary]).compact.map(&:to_f)
    ranges = {
      "0-5L" => 0..500000,
      "5-10L" => 500001..1000000,
      "10-15L" => 1000001..1500000,
      "15-25L" => 1500001..2500000,
      "25L+" => 2500001..100000000
    }

    ranges.map do |label, range|
      {
        label: label,
        count: all_salaries.count { |s| range.include?(s) },
        is_user: range.include?(@user.current_salary.to_f)
      }
    end
  end

  def build_comparison(peers, salary_pct, skill_pct, interview_pct)
    avg_salary = peers.average(:current_salary).to_f.round
    avg_exp = peers.average(:experience_years).to_f.round(1)

    {
      your_salary: @user.current_salary.to_f.round,
      peer_avg_salary: avg_salary,
      salary_diff_pct: avg_salary > 0 ? ((@user.current_salary.to_f - avg_salary) / avg_salary * 100).round(1) : 0,
      your_experience: @user.experience_years,
      peer_avg_experience: avg_exp,
      salary_percentile: salary_pct,
      skill_percentile: skill_pct,
      interview_percentile: interview_pct
    }
  end

  def build_ranking(peers)
    all = (peers.to_a + [@user]).sort_by { |u| -(u.current_salary.to_f) }
    rank = all.index(@user).to_i + 1
    {
      rank: rank,
      total: all.size,
      top_pct: (rank.to_f / all.size * 100).round(1)
    }
  end

  def latest_resume_skills(user)
    resume = user.resumes.where(parsing_status: 2).order(created_at: :desc).first
    resume&.parsed_data&.dig("skills") || []
  end
end
