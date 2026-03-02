class GeminiRoadmapService
  def initialize(user, skill_gap_data:, salary_data:)
    @user = user
    @skill_gap_data = skill_gap_data
    @salary_data = salary_data
  end

  def generate
    cache_key = "gemini/roadmap/user_#{@user.id}"

    Rails.cache.fetch(cache_key, expires_in: 24.hours) do
      ai_roadmap = fetch_ai_roadmap
      return nil unless ai_roadmap

      fallback = RoadmapService.new(@user, skill_gap_data: @skill_gap_data, salary_data: @salary_data).generate
      merge_with_fallback(fallback, ai_roadmap)
    end
  rescue => e
    Rails.logger.error("GeminiRoadmapService error: #{e.message}")
    nil
  end

  private

  def fetch_ai_roadmap
    user_profile = {
      role: @user.role,
      city: @user.city,
      experience_years: @user.experience_years,
      current_salary: @user.current_salary
    }

    prompt = GeminiPrompts.career_roadmap_prompt(user_profile, @skill_gap_data, @salary_data)
    GeminiClient.new.generate(prompt, response_schema: response_schema)
  end

  def merge_with_fallback(fallback, ai_result)
    {
      timeline: ai_result["timeline"].presence || fallback[:timeline],
      certifications: ai_result["certifications"].presence || fallback[:certifications],
      salary_projection: ai_result["salary_projection"].presence || fallback[:salary_projection],
      milestones: ai_result["milestones"].presence || fallback[:milestones],
      ai_insights: ai_result["ai_insights"]
    }
  end

  def response_schema
    {
      type: "OBJECT",
      properties: {
        timeline: {
          type: "ARRAY",
          items: {
            type: "OBJECT",
            properties: {
              month: { type: "INTEGER" },
              action: { type: "STRING" },
              skill_focus: { type: "STRING" }
            }
          }
        },
        certifications: {
          type: "ARRAY",
          items: { type: "STRING" }
        },
        salary_projection: {
          type: "OBJECT",
          properties: {
            projected_6_months: { type: "NUMBER" },
            projected_12_months: { type: "NUMBER" }
          }
        },
        milestones: {
          type: "ARRAY",
          items: {
            type: "OBJECT",
            properties: {
              month: { type: "INTEGER" },
              title: { type: "STRING" },
              description: { type: "STRING" }
            }
          }
        },
        ai_insights: { type: "STRING" }
      }
    }
  end
end
