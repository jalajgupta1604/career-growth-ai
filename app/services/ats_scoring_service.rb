class AtsScoringService
  def initialize(resume)
    @resume = resume
    @user = resume.user
  end

  def score
    raw_text = @resume.parsed_data&.dig("raw_text") || ""
    target_role = @user.role || "Software Developer"

    prompt = GeminiPrompts.ats_scoring_prompt(raw_text, target_role)
    result = GeminiClient.new.generate(prompt, response_schema: ats_schema)

    result ||= fallback_score(raw_text, target_role)

    @resume.update!(
      ats_score: result["ats_score"],
      ats_data: result
    )

    result
  end

  private

  def fallback_score(raw_text, target_role)
    skills = @resume.parsed_data&.dig("skills") || []
    experience = @resume.parsed_data&.dig("experience_entries") || []
    projects = @resume.parsed_data&.dig("projects") || []

    keyword_score = [skills.size * 5, 100].min
    content_score = calculate_content_score(experience, projects)
    format_score = calculate_format_score(raw_text)
    ats_score = ((keyword_score + content_score + format_score) / 3.0).round

    {
      "ats_score" => ats_score,
      "keyword_score" => keyword_score,
      "format_score" => format_score,
      "content_score" => content_score,
      "matched_keywords" => skills.first(10),
      "missing_keywords" => [],
      "format_issues" => detect_format_issues(raw_text),
      "content_suggestions" => [
        "Add quantifiable achievements to experience entries",
        "Include relevant technical keywords for #{target_role}",
        "Add a professional summary section",
        "List certifications if any",
        "Use action verbs to start bullet points"
      ],
      "section_scores" => {
        "skills" => keyword_score,
        "experience" => [experience.size * 15, 100].min,
        "projects" => [projects.size * 20, 100].min,
        "summary" => raw_text.length > 200 ? 60 : 30,
        "education" => 50
      },
      "overall_verdict" => ats_score >= 70 ? "ats_optimized" : (ats_score >= 40 ? "needs_improvement" : "major_rework_needed")
    }
  end

  def calculate_content_score(experience, projects)
    score = 0
    score += [experience.size * 15, 50].min
    score += [projects.size * 15, 30].min
    score += 20 if experience.any? { |e| e.to_s.match?(/\d+%|\d+x|\$[\d,]+/) }
    [score, 100].min
  end

  def calculate_format_score(raw_text)
    score = 50
    score += 10 if raw_text.include?("Experience") || raw_text.include?("EXPERIENCE")
    score += 10 if raw_text.include?("Skills") || raw_text.include?("SKILLS")
    score += 10 if raw_text.include?("Education") || raw_text.include?("EDUCATION")
    score += 10 if raw_text.include?("Projects") || raw_text.include?("PROJECTS")
    score += 10 if raw_text.lines.any? { |l| l.strip.start_with?("•", "-", "●") }
    [score, 100].min
  end

  def detect_format_issues(raw_text)
    issues = []
    issues << "Missing Skills section" unless raw_text.match?(/skills/i)
    issues << "Missing Experience section" unless raw_text.match?(/experience/i)
    issues << "Missing Education section" unless raw_text.match?(/education/i)
    issues << "No bullet points detected" unless raw_text.match?(/[•\-●]/)
    issues << "Resume may be too short" if raw_text.length < 500
    issues << "Resume may be too long" if raw_text.length > 5000
    issues
  end

  def ats_schema
    {
      type: "OBJECT",
      properties: {
        ats_score: { type: "INTEGER" },
        keyword_score: { type: "INTEGER" },
        format_score: { type: "INTEGER" },
        content_score: { type: "INTEGER" },
        matched_keywords: { type: "ARRAY", items: { type: "STRING" } },
        missing_keywords: { type: "ARRAY", items: { type: "STRING" } },
        format_issues: { type: "ARRAY", items: { type: "STRING" } },
        content_suggestions: { type: "ARRAY", items: { type: "STRING" } },
        section_scores: {
          type: "OBJECT",
          properties: {
            summary: { type: "INTEGER" },
            experience: { type: "INTEGER" },
            skills: { type: "INTEGER" },
            education: { type: "INTEGER" },
            projects: { type: "INTEGER" }
          }
        },
        overall_verdict: { type: "STRING" }
      }
    }
  end
end
