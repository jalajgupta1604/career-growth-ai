class OfferAnalysisService
  def initialize(user)
    @user = user
  end

  def analyze(params)
    market_data = fetch_market_data
    offer_data = {
      company_name: params[:company_name],
      offer_role: params[:offer_role] || @user.role,
      base_salary: params[:base_salary],
      total_ctc: params[:total_ctc],
      components: params[:components]
    }

    user_profile = {
      role: @user.role,
      experience_years: @user.experience_years,
      city: @user.city,
      current_salary: @user.current_salary
    }

    prompt = GeminiPrompts.offer_analysis_prompt(offer_data, user_profile, market_data)
    result = GeminiClient.new.generate(prompt, response_schema: analysis_schema)

    result ||= fallback_analysis(offer_data, market_data)

    @user.offer_analyses.create!(
      company_name: params[:company_name],
      offer_role: params[:offer_role] || @user.role,
      base_salary: params[:base_salary],
      total_ctc: params[:total_ctc],
      components_data: parse_components(params[:components]),
      analysis_data: result,
      red_flags: result["red_flags"] || [],
      green_flags: result["green_flags"] || [],
      offer_score: result["offer_score"],
      verdict: result["verdict"]
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

  def parse_components(components_text)
    return {} if components_text.blank?
    lines = components_text.split("\n").map(&:strip).reject(&:empty?)
    lines.each_with_object({}) do |line, hash|
      key, value = line.split(/[:–-]/, 2).map(&:strip)
      hash[key] = value if key.present?
    end
  end

  def fallback_analysis(offer_data, market_data)
    base = offer_data[:base_salary].to_f
    ctc = offer_data[:total_ctc].to_f
    median = market_data[:median_salary].to_f

    score = if median > 0
      pct = (base / median * 100).round
      [[pct, 100].min, 0].max
    else
      50
    end

    verdict = case score
    when 80..100 then "strong_accept"
    when 60..79 then "accept"
    when 40..59 then "negotiate"
    when 20..39 then "caution"
    else "decline"
    end

    variable_pct = ctc > 0 ? ((ctc - base) / ctc * 100).round(1) : 0

    red_flags = []
    red_flags << "High variable component (#{variable_pct}% of CTC)" if variable_pct > 30
    red_flags << "Base salary below market median" if median > 0 && base < median
    red_flags << "Significant gap between base and CTC" if ctc > base * 1.5

    green_flags = []
    green_flags << "Base salary above market median" if median > 0 && base >= median
    green_flags << "Competitive total CTC" if median > 0 && ctc >= median * 1.1
    green_flags << "Low variable component" if variable_pct < 20

    {
      "offer_score" => score,
      "verdict" => verdict,
      "salary_analysis" => "Offer is #{median > 0 ? ((base / median - 1) * 100).round(1) : 'N/A'}% compared to market median.",
      "ctc_breakdown_analysis" => "Variable component is #{variable_pct}% of total CTC.",
      "red_flags" => red_flags,
      "green_flags" => green_flags,
      "recommendations" => [
        "Compare this offer with at least 2 other companies",
        "Negotiate on base salary rather than variable components",
        "Ask for the salary structure breakdown in writing",
        "Check Glassdoor reviews for compensation insights"
      ],
      "estimated_take_home" => (base * 0.7 / 12).round,
      "growth_potential" => "Evaluate based on company stage, team size, and role scope."
    }
  end

  def analysis_schema
    {
      type: "OBJECT",
      properties: {
        offer_score: { type: "INTEGER" },
        verdict: { type: "STRING" },
        salary_analysis: { type: "STRING" },
        ctc_breakdown_analysis: { type: "STRING" },
        red_flags: { type: "ARRAY", items: { type: "STRING" } },
        green_flags: { type: "ARRAY", items: { type: "STRING" } },
        recommendations: { type: "ARRAY", items: { type: "STRING" } },
        estimated_take_home: { type: "NUMBER" },
        growth_potential: { type: "STRING" }
      }
    }
  end
end
