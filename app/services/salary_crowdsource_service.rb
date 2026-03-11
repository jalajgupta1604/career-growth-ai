class SalaryCrowdsourceService
  def initialize(user = nil)
    @user = user
  end

  def submit(params)
    @user.salary_submissions.create!(
      role: params[:role] || @user.role,
      city: params[:city] || @user.city,
      experience_years: params[:experience_years] || @user.experience_years,
      base_salary: params[:base_salary],
      total_ctc: params[:total_ctc],
      company_name: params[:company_name],
      company_type: params[:company_type],
      components_data: parse_components(params[:components]),
      anonymous: params[:anonymous] != "false"
    )
  end

  def explore(filters = {})
    scope = SalarySubmission.all

    scope = scope.for_role(filters[:role]) if filters[:role].present?
    scope = scope.for_city(filters[:city]) if filters[:city].present?
    if filters[:experience_years].present?
      range = SalarySubmission.experience_range_for(filters[:experience_years].to_i)
      scope = scope.for_experience(range)
    end
    scope = scope.where(company_type: filters[:company_type]) if filters[:company_type].present?

    submissions = scope.recent.limit(100)

    {
      submissions: submissions,
      stats: calculate_stats(scope),
      distribution: calculate_distribution(scope),
      total_count: scope.count
    }
  end

  def available_roles
    SalarySubmission.distinct.pluck(:role).sort
  end

  def available_cities
    SalarySubmission.distinct.pluck(:city).sort
  end

  private

  def calculate_stats(scope)
    salaries = scope.pluck(:base_salary).map(&:to_f)
    return { min: 0, max: 0, median: 0, average: 0, count: 0 } if salaries.empty?

    sorted = salaries.sort
    mid = sorted.size / 2
    median = sorted.size.odd? ? sorted[mid] : (sorted[mid - 1] + sorted[mid]) / 2.0

    {
      min: sorted.first.round,
      max: sorted.last.round,
      median: median.round,
      average: (salaries.sum / salaries.size).round,
      count: salaries.size
    }
  end

  def calculate_distribution(scope)
    ranges = {
      "0-5L" => 0..500000,
      "5-10L" => 500001..1000000,
      "10-15L" => 1000001..1500000,
      "15-25L" => 1500001..2500000,
      "25-50L" => 2500001..5000000,
      "50L+" => 5000001..100000000
    }

    ranges.map do |label, range|
      count = scope.where(base_salary: range).count
      { label: label, count: count }
    end
  end

  def parse_components(text)
    return {} if text.blank?
    lines = text.to_s.split("\n").map(&:strip).reject(&:empty?)
    lines.each_with_object({}) do |line, hash|
      key, value = line.split(/[:–-]/, 2).map(&:strip)
      hash[key] = value if key.present?
    end
  end
end
