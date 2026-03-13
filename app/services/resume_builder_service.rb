class ResumeBuilderService
  def initialize(user)
    @user = user
  end

  def generate(target_role)
    resume = @user.generated_resumes.create!(
      target_role: target_role,
      status: :generating
    )

    skills = extract_user_skills
    experience = extract_user_experience

    prompt = GeminiPrompts.resume_builder_prompt(
      @user.full_name || "Professional",
      @user.email,
      target_role,
      @user.experience_years || 0,
      @user.city || "India",
      skills,
      experience
    )

    result = GeminiClient.new.generate(prompt, response_schema: resume_schema)

    if result
      resume.update!(resume_data: result, status: :completed)
    else
      resume.update!(status: :failed)
    end

    resume
  rescue => e
    Rails.logger.error("Resume generation failed: #{e.message}")
    resume&.update!(status: :failed)
    resume
  end

  def recent_resumes(limit = 10)
    @user.generated_resumes.recent.limit(limit)
  end

  private

  def extract_user_skills
    latest_resume = @user.resumes.order(created_at: :desc).first
    return [] unless latest_resume&.parsed_data

    latest_resume.parsed_data["skills"] || []
  end

  def extract_user_experience
    latest_resume = @user.resumes.order(created_at: :desc).first
    return [] unless latest_resume&.parsed_data

    latest_resume.parsed_data["experience_entries"] || []
  end

  def resume_schema
    {
      type: "OBJECT",
      properties: {
        summary: { type: "STRING" },
        skills: { type: "ARRAY", items: { type: "OBJECT", properties: { category: { type: "STRING" }, items: { type: "ARRAY", items: { type: "STRING" } } } } },
        experience: { type: "ARRAY", items: { type: "OBJECT", properties: { title: { type: "STRING" }, company: { type: "STRING" }, duration: { type: "STRING" }, bullets: { type: "ARRAY", items: { type: "STRING" } } } } },
        projects: { type: "ARRAY", items: { type: "OBJECT", properties: { name: { type: "STRING" }, description: { type: "STRING" }, technologies: { type: "STRING" } } } },
        certifications: { type: "ARRAY", items: { type: "STRING" } },
        ats_keywords: { type: "ARRAY", items: { type: "STRING" } },
        tips: { type: "ARRAY", items: { type: "STRING" } }
      }
    }
  end
end
