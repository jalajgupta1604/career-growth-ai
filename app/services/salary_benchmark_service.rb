class SalaryBenchmarkService
  def initialize(user)
    @user = user
  end

  def analyze
    benchmark = find_benchmark
    return nil unless benchmark

    {
      benchmark: benchmark,
      underpaid_percentage: calculate_underpaid_percentage(benchmark),
      salary_range: {
        min: benchmark.min_salary,
        median: benchmark.median_salary,
        max: benchmark.max_salary
      },
      market_position: market_position(benchmark)
    }
  end

  private

  def find_benchmark
    experience_range = experience_range_for(@user.experience_years)
    SalaryBenchmark.lookup(
      role: @user.role,
      city: @user.city,
      experience_range: experience_range
    )
  end

  def calculate_underpaid_percentage(benchmark)
    return 0 if benchmark.median_salary.zero?
    ((benchmark.median_salary - @user.current_salary) / benchmark.median_salary * 100).round(1)
  end

  def market_position(benchmark)
    salary = @user.current_salary.to_f
    if salary >= benchmark.max_salary.to_f
      "above_market"
    elsif salary >= benchmark.median_salary.to_f
      "at_market"
    elsif salary >= benchmark.min_salary.to_f
      "below_median"
    else
      "significantly_underpaid"
    end
  end

  def experience_range_for(years)
    case years
    when 0..2 then "0-2"
    when 3..5 then "3-5"
    when 6..8 then "6-8"
    when 9..12 then "9-12"
    else "12+"
    end
  end
end
