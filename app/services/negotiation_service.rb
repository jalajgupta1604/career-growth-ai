class NegotiationService
  def initialize(user)
    @user = user
  end

  def generate(params)
    market_data = fetch_market_data
    offer_data = {
      company_name: params[:company_name],
      offer_role: params[:offer_role],
      current_offer: params[:current_offer],
      expected_salary: params[:expected_salary],
      benefits: params[:benefits]
    }

    user_profile = {
      role: @user.role,
      experience_years: @user.experience_years,
      city: @user.city,
      current_salary: @user.current_salary
    }

    prompt = GeminiPrompts.negotiation_strategy_prompt(user_profile, offer_data, market_data)
    result = GeminiClient.new.generate(prompt, response_schema: strategy_schema)

    result ||= fallback_strategy(offer_data, market_data)

    @user.negotiation_sessions.create!(
      current_offer: params[:current_offer],
      expected_salary: params[:expected_salary],
      company_name: params[:company_name],
      offer_role: params[:offer_role],
      benefits_data: { raw: params[:benefits] },
      strategy_data: result,
      talking_points: result["talking_points"] || [],
      counter_offer_data: result["counter_offer"] || {},
      negotiation_score: result["negotiation_score"]
    )
  end

  private

  def fetch_market_data
    salary_data = SalaryBenchmarkService.new(@user).analyze
    if salary_data
      {
        median_salary: salary_data[:salary_range][:median],
        max_salary: salary_data[:salary_range][:max],
        min_salary: salary_data[:salary_range][:min]
      }
    else
      { median_salary: 0, max_salary: 0, min_salary: 0 }
    end
  end

  def fallback_strategy(offer_data, market_data)
    {
      "negotiation_score" => 50,
      "verdict" => "moderate_position",
      "counter_offer" => { "amount" => offer_data[:expected_salary], "reasoning" => "Based on your experience and market data" },
      "talking_points" => [
        { "title" => "Market Research", "script" => "Based on my research, the market median for this role is ₹#{market_data[:median_salary]}." },
        { "title" => "Value Proposition", "script" => "I bring #{@user.experience_years} years of experience with proven impact." },
        { "title" => "Competitive Offers", "script" => "I am exploring multiple opportunities in the current market." }
      ],
      "email_template" => "Thank you for the offer. I'd like to discuss the compensation package further.",
      "dos" => ["Research market rates", "Know your minimum", "Be professional", "Get the offer in writing"],
      "donts" => ["Don't accept immediately", "Don't share other offers' details", "Don't be emotional", "Don't give ultimatums"],
      "timeline_advice" => "Take 2-3 days to evaluate the offer before responding."
    }
  end

  def strategy_schema
    {
      type: "OBJECT",
      properties: {
        negotiation_score: { type: "INTEGER" },
        verdict: { type: "STRING" },
        counter_offer: {
          type: "OBJECT",
          properties: { amount: { type: "NUMBER" }, reasoning: { type: "STRING" } }
        },
        talking_points: {
          type: "ARRAY",
          items: {
            type: "OBJECT",
            properties: { title: { type: "STRING" }, script: { type: "STRING" } }
          }
        },
        email_template: { type: "STRING" },
        dos: { type: "ARRAY", items: { type: "STRING" } },
        donts: { type: "ARRAY", items: { type: "STRING" } },
        timeline_advice: { type: "STRING" }
      }
    }
  end
end
