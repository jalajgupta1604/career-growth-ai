class EnterpriseAnalyticsService
  def initialize(company)
    @company = company
  end

  def generate_snapshot
    members = @company.company_members.includes(:user)
    users = members.map(&:user)
    period = Date.current.strftime("%Y-%m")

    @company.company_analytics_snapshots.find_or_initialize_by(period: period).tap do |snapshot|
      snapshot.update!(
        salary_data: salary_analytics(users),
        skill_data: skill_analytics(users),
        hiring_data: hiring_analytics(users),
        benchmark_data: benchmark_analytics(users),
        attrition_data: attrition_analytics(users),
        team_size: users.size,
        avg_salary: users.map { |u| u.current_salary.to_f }.sum / [users.size, 1].max,
        avg_experience: users.map { |u| u.experience_years.to_f }.sum / [users.size, 1].max
      )
    end
  end

  def dashboard_data
    snapshot = @company.latest_snapshot
    members = @company.company_members.includes(:user)

    {
      company: @company,
      snapshot: snapshot,
      members: members,
      team_size: members.count,
      roles_breakdown: roles_breakdown(members),
      salary_summary: snapshot&.salary_data || {},
      skill_summary: snapshot&.skill_data || {},
      hiring_summary: snapshot&.hiring_data || {},
      benchmark_summary: snapshot&.benchmark_data || {}
    }
  end

  private

  def salary_analytics(users)
    salaries = users.map { |u| u.current_salary.to_f }.reject(&:zero?)
    return {} if salaries.empty?

    sorted = salaries.sort
    mid = sorted.size / 2

    {
      min: sorted.first.round,
      max: sorted.last.round,
      median: (sorted.size.odd? ? sorted[mid] : (sorted[mid - 1] + sorted[mid]) / 2.0).round,
      average: (salaries.sum / salaries.size).round,
      total_payroll: salaries.sum.round,
      distribution: salary_distribution(salaries)
    }
  end

  def salary_distribution(salaries)
    ranges = { "0-5L" => 0..500000, "5-10L" => 500001..1000000, "10-15L" => 1000001..1500000, "15-25L" => 1500001..2500000, "25L+" => 2500001..100000000 }
    ranges.map { |label, range| { label: label, count: salaries.count { |s| range.include?(s) } } }
  end

  def skill_analytics(users)
    all_skills = users.flat_map do |u|
      resume = u.resumes.where(parsing_status: :completed).order(created_at: :desc).first
      resume&.parsed_data&.dig("skills") || []
    end

    freq = all_skills.tally.sort_by { |_, c| -c }
    {
      total_unique_skills: freq.size,
      top_skills: freq.first(15).map { |name, count| { name: name, count: count } },
      skill_coverage: freq.size > 0 ? (freq.count { |_, c| c > 1 }.to_f / freq.size * 100).round(1) : 0
    }
  end

  def hiring_analytics(users)
    recent = users.select { |u| u.created_at > 3.months.ago }
    {
      recent_hires: recent.size,
      avg_experience_new: recent.any? ? (recent.sum { |u| u.experience_years.to_f } / recent.size).round(1) : 0,
      roles_hiring: recent.map(&:role).tally
    }
  end

  def benchmark_analytics(users)
    roles = users.map(&:role).compact.tally.sort_by { |_, c| -c }
    {
      roles_distribution: roles.map { |role, count| { role: role, count: count } },
      experience_distribution: experience_distribution(users),
      city_distribution: users.map(&:city).compact.tally.sort_by { |_, c| -c }.first(10).map { |city, count| { city: city, count: count } }
    }
  end

  def experience_distribution(users)
    buckets = { "0-2 years" => 0..2, "3-5 years" => 3..5, "6-8 years" => 6..8, "9-12 years" => 9..12, "12+ years" => 12..50 }
    buckets.map { |label, range| { label: label, count: users.count { |u| range.include?(u.experience_years.to_i) } } }
  end

  def attrition_analytics(users)
    { team_tenure_avg: users.any? ? (users.sum { |u| ((Time.current - u.created_at) / 1.month).round(1) } / users.size).round(1) : 0 }
  end

  def roles_breakdown(members)
    members.joins(:user).group("users.role").count
  end
end
