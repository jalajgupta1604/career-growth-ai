class GeminiGrowthHacksService
  def initialize(user, skill_data:, salary_data:)
    @user = user
    @skill_data = skill_data
    @salary_data = salary_data
  end

  def generate
    cache_key = "gemini/growth_hacks/user_#{@user.id}"

    Rails.cache.fetch(cache_key, expires_in: 24.hours) do
      fetch_ai_hacks
    end
  rescue => e
    Rails.logger.error("GeminiGrowthHacksService error: #{e.message}")
    nil
  end

  private

  def fetch_ai_hacks
    user_profile = {
      role: @user.role,
      city: @user.city,
      experience_years: @user.experience_years
    }

    matched_skills = (@skill_data[:matched_skills] || []).map { |s| s[:name] }
    missing_skills = (@skill_data[:top_skills_to_learn] || []).map { |s| s[:name] }
    salary_gap = @salary_data&.dig(:underpaid_percentage) || 0

    prompt = GeminiPrompts.growth_hacks_prompt(user_profile, matched_skills, missing_skills, salary_gap)
    result = GeminiClient.new.generate(prompt, response_schema: response_schema)
    return nil unless result

    normalize_hacks(result)
  end

  def normalize_hacks(result)
    hacks = result["hacks"] || result
    hacks = [hacks] unless hacks.is_a?(Array)

    hacks.map do |hack|
      {
        "title" => hack["title"].to_s,
        "description" => hack["description"].to_s,
        "impact_label" => hack["impact_label"].to_s
      }
    end
  end

  def response_schema
    {
      type: "OBJECT",
      properties: {
        hacks: {
          type: "ARRAY",
          items: {
            type: "OBJECT",
            properties: {
              title: { type: "STRING" },
              description: { type: "STRING" },
              impact_label: { type: "STRING" }
            }
          }
        }
      }
    }
  end
end
