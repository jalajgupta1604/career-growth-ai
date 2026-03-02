module GeminiPrompts
  module_function

  def resume_analysis_prompt(raw_text, role)
    <<~PROMPT
      You are an expert resume analyst for the Indian tech job market.
      Analyze the following resume text for a #{role} position.

      Extract and return:
      - skills: array of technical and soft skills found
      - projects: array of projects with name, description, and technologies used
      - certifications: array of certification names
      - experience_entries: array with title, company, duration, and key highlights
      - summary: a 2-3 sentence professional summary of the candidate

      Resume text:
      ---
      #{raw_text}
      ---

      Return well-structured JSON only.
    PROMPT
  end

  def career_roadmap_prompt(user_profile, skill_gap_data, salary_data)
    missing_skills = (skill_gap_data[:top_skills_to_learn] || []).map { |s| s[:name] }.join(", ")
    matched_skills = (skill_gap_data[:matched_skills] || []).map { |s| s[:name] }.join(", ")
    current_salary = user_profile[:current_salary]
    median_salary = salary_data.dig(:benchmark)&.respond_to?(:median_salary) ? salary_data[:benchmark].median_salary : salary_data.dig(:benchmark, :median_salary)

    <<~PROMPT
      You are a senior career coach specializing in the Indian tech industry.

      User profile:
      - Role: #{user_profile[:role]}
      - City: #{user_profile[:city]}
      - Experience: #{user_profile[:experience_years]} years
      - Current Salary: #{current_salary} INR per annum
      - Market Median Salary: #{median_salary} INR per annum
      - Current Skills: #{matched_skills}
      - Skills to Learn: #{missing_skills}

      Generate a personalized 12-month career roadmap with:
      - timeline: array of monthly action items (month number, action, skill focus)
      - certifications: top 3 recommended certifications with reasoning
      - salary_projection: realistic 6-month and 12-month salary targets
      - milestones: 5 key milestones at months 1, 3, 6, 9, 12
      - ai_insights: 2-3 sentences of personalized career advice specific to this person's situation

      Be specific and actionable. Tailor advice to the Indian tech job market.
      Return well-structured JSON only.
    PROMPT
  end

  def growth_hacks_prompt(user_profile, matched_skills, missing_skills, salary_gap)
    <<~PROMPT
      You are a career growth strategist for Indian tech professionals.

      User profile:
      - Role: #{user_profile[:role]}
      - City: #{user_profile[:city]}
      - Experience: #{user_profile[:experience_years]} years
      - Current Skills: #{matched_skills.join(', ')}
      - Missing Skills: #{missing_skills.join(', ')}
      - Salary Gap: #{salary_gap}% below market median

      Generate 4-5 highly personalized, actionable career growth hacks.
      Each hack should have:
      - title: short catchy title (5-8 words)
      - description: 1-2 sentences with specific, actionable advice
      - impact_label: expected impact (e.g., "+15% salary", "2x interview calls", "High ROI")

      Focus on practical, immediately actionable advice specific to this person's profile.
      Reference their actual skills and gaps — do not give generic advice.
      Return well-structured JSON only.
    PROMPT
  end

  def interview_questions_prompt(category_name, topic, difficulty, role)
    <<~PROMPT
      You are a senior technical interviewer at a top Indian tech company.

      Generate 3-5 practice interview questions for:
      - Category: #{category_name}
      - Topic: #{topic}
      - Difficulty: #{difficulty}
      - Target Role: #{role}

      For each question provide:
      - question: the interview question
      - model_answer: a comprehensive model answer (3-5 sentences)
      - difficulty: easy, medium, or hard

      Questions should be realistic and commonly asked in Indian tech interviews.
      Return well-structured JSON only.
    PROMPT
  end
end
