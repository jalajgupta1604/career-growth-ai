class GeminiResumeService
  RESPONSE_SCHEMA = {
    type: "OBJECT",
    properties: {
      skills: { type: "ARRAY", items: { type: "STRING" } },
      projects: {
        type: "ARRAY",
        items: {
          type: "OBJECT",
          properties: {
            name: { type: "STRING" },
            description: { type: "STRING" },
            technologies: { type: "STRING" }
          }
        }
      },
      certifications: { type: "ARRAY", items: { type: "STRING" } },
      experience_entries: {
        type: "ARRAY",
        items: {
          type: "OBJECT",
          properties: {
            title: { type: "STRING" },
            company: { type: "STRING" },
            duration: { type: "STRING" },
            highlights: { type: "STRING" }
          }
        }
      },
      summary: { type: "STRING" }
    }
  }.freeze

  def initialize(resume)
    @resume = resume
  end

  def parse
    raw_text = @resume.parsed_data&.dig("raw_text")
    return nil if raw_text.blank?

    role = @resume.user&.role || "Software Developer"
    prompt = GeminiPrompts.resume_analysis_prompt(raw_text, role)

    result = GeminiClient.new.generate(prompt, response_schema: RESPONSE_SCHEMA)
    return nil unless result

    normalize_result(result)
  rescue => e
    Rails.logger.error("GeminiResumeService error: #{e.message}")
    nil
  end

  private

  def normalize_result(result)
    {
      "skills" => Array(result["skills"]),
      "projects" => Array(result["projects"]),
      "certifications" => Array(result["certifications"]),
      "experience_entries" => Array(result["experience_entries"]),
      "summary" => result["summary"].to_s
    }
  end
end
