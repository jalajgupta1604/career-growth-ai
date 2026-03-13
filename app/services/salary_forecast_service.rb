class SalaryForecastService
  def initialize(user)
    @user = user
  end

  def generate_forecast
    forecast = @user.salary_forecasts.create!(
      current_salary: @user.current_salary || 0,
      status: :processing
    )

    resume = @user.resumes.where(parsing_status: :completed).order(created_at: :desc).first
    skills = resume&.parsed_data&.dig("skills") || []

    prompt = GeminiPrompts.salary_forecast_prompt(
      @user.role || "Software Developer",
      @user.city || "Bangalore",
      @user.experience_years || 3,
      @user.current_salary || 0,
      skills
    )

    result = GeminiClient.new.generate(prompt, response_schema: forecast_schema)

    if result
      forecast.update!(
        projected_salaries: result["projections"] || result,
        skill_plan: result["skill_plan"] || {},
        market_factors: result["market_factors"] || {},
        status: :completed
      )
    else
      forecast.update!(status: :failed)
    end

    forecast
  rescue => e
    Rails.logger.error("Salary forecast failed: #{e.message}")
    forecast&.update!(status: :failed)
    forecast
  end

  private

  def forecast_schema
    {
      type: "OBJECT",
      properties: {
        projections: {
          type: "OBJECT",
          properties: {
            year_1: { type: "OBJECT", properties: { min: { type: "INTEGER" }, max: { type: "INTEGER" }, likely: { type: "INTEGER" } } },
            year_2: { type: "OBJECT", properties: { min: { type: "INTEGER" }, max: { type: "INTEGER" }, likely: { type: "INTEGER" } } },
            year_3: { type: "OBJECT", properties: { min: { type: "INTEGER" }, max: { type: "INTEGER" }, likely: { type: "INTEGER" } } }
          }
        },
        skill_plan: {
          type: "ARRAY",
          items: { type: "OBJECT", properties: { skill: { type: "STRING" }, impact: { type: "STRING" }, salary_boost_percentage: { type: "INTEGER" } } }
        },
        market_factors: {
          type: "ARRAY",
          items: { type: "OBJECT", properties: { factor: { type: "STRING" }, impact: { type: "STRING" }, direction: { type: "STRING" } } }
        },
        summary: { type: "STRING" }
      }
    }
  end
end
