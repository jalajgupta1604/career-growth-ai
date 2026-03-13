class CareerSimulationService
  def initialize(user)
    @user = user
  end

  def simulate(scenario_params)
    simulation = @user.career_simulations.create!(
      scenario_data: scenario_params,
      status: :processing
    )

    prompt = GeminiPrompts.career_simulation_prompt(
      @user.role || "Software Developer",
      @user.city || "Bangalore",
      @user.experience_years || 3,
      @user.current_salary || 0,
      scenario_params
    )

    result = GeminiClient.new.generate(prompt, response_schema: simulation_schema)

    if result
      simulation.update!(result_data: result, status: :completed)
    else
      simulation.update!(status: :failed)
    end

    simulation
  rescue => e
    Rails.logger.error("Career simulation failed: #{e.message}")
    simulation&.update!(status: :failed)
    simulation
  end

  def recent_simulations(limit = 10)
    @user.career_simulations.recent.limit(limit)
  end

  private

  def simulation_schema
    {
      type: "OBJECT",
      properties: {
        projected_salary: { type: "INTEGER" },
        salary_increase_percentage: { type: "INTEGER" },
        timeline_months: { type: "INTEGER" },
        confidence_level: { type: "STRING" },
        steps: { type: "ARRAY", items: { type: "OBJECT", properties: { month: { type: "INTEGER" }, action: { type: "STRING" }, impact: { type: "STRING" } } } },
        risks: { type: "ARRAY", items: { type: "STRING" } },
        opportunities: { type: "ARRAY", items: { type: "STRING" } },
        summary: { type: "STRING" }
      }
    }
  end
end
