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

  def mock_interview_prompt(interview_type, difficulty, role, user_profile)
    <<~PROMPT
      You are a senior technical interviewer at a top Indian tech company conducting a #{difficulty} #{interview_type} interview.

      Candidate profile:
      - Role: #{role}
      - Experience: #{user_profile[:experience_years]} years
      - City: #{user_profile[:city]}
      - Skills: #{user_profile[:skills]&.join(', ')}

      Generate exactly 5 interview questions for a #{interview_type} interview.
      Each question should have:
      - question: the interview question (clear, specific)
      - category: topic category (e.g., "Data Structures", "System Design", "Leadership")
      - expected_time_minutes: estimated time to answer (2-10 minutes)
      - evaluation_criteria: array of 3-4 key points the interviewer looks for
      - ideal_answer_outline: a 3-5 point outline of an ideal answer

      Make questions progressively harder. Tailor to the Indian tech market.
      Return well-structured JSON only.
    PROMPT
  end

  def mock_interview_feedback_prompt(question, user_answer, role)
    <<~PROMPT
      You are a senior technical interviewer evaluating a candidate's answer.

      Role: #{role}
      Question: #{question}
      Candidate's Answer: #{user_answer}

      Evaluate and provide:
      - score: number from 1-10
      - strengths: array of 2-3 things done well
      - improvements: array of 2-3 areas to improve
      - model_answer: a concise ideal answer (3-5 sentences)
      - tip: one actionable tip for next time

      Be constructive and specific. Reference the Indian tech interview context.
      Return well-structured JSON only.
    PROMPT
  end

  def negotiation_strategy_prompt(user_profile, offer_data, market_data)
    <<~PROMPT
      You are an expert salary negotiation coach for Indian tech professionals.

      Candidate profile:
      - Role: #{user_profile[:role]}
      - Experience: #{user_profile[:experience_years]} years
      - City: #{user_profile[:city]}
      - Current Salary: ₹#{user_profile[:current_salary]} per annum

      Offer details:
      - Company: #{offer_data[:company_name]}
      - Offered Role: #{offer_data[:offer_role] || user_profile[:role]}
      - Current Offer: ₹#{offer_data[:current_offer]} per annum
      - Expected Salary: ₹#{offer_data[:expected_salary]} per annum
      - Benefits: #{offer_data[:benefits]}

      Market context:
      - Market Median: ₹#{market_data[:median_salary]} per annum
      - Market Max: ₹#{market_data[:max_salary]} per annum

      Generate a comprehensive negotiation strategy with:
      - negotiation_score: 1-100 score of the offer's strength
      - verdict: one of "strong_position", "moderate_position", "weak_position"
      - counter_offer: recommended counter-offer amount with reasoning
      - talking_points: array of 5-6 specific negotiation talking points (each with title and script)
      - email_template: a professional negotiation email template
      - dos: array of 4-5 things to do during negotiation
      - donts: array of 4-5 things to avoid during negotiation
      - timeline_advice: recommended timeline/approach for the negotiation

      Be specific to the Indian tech market. Include actual numbers and scripts.
      Return well-structured JSON only.
    PROMPT
  end

  def ats_scoring_prompt(resume_text, target_role)
    <<~PROMPT
      You are an expert ATS (Applicant Tracking System) analyzer for the Indian tech job market.

      Resume text:
      ---
      #{resume_text}
      ---

      Target role: #{target_role}

      Analyze this resume as an ATS system would and provide:
      - ats_score: overall ATS compatibility score (0-100)
      - keyword_score: keyword match score (0-100)
      - format_score: formatting/structure score (0-100)
      - content_score: content quality score (0-100)
      - matched_keywords: array of keywords found that match the target role
      - missing_keywords: array of important keywords missing for the target role
      - format_issues: array of formatting issues (e.g., "Missing section headers", "No bullet points")
      - content_suggestions: array of 5-6 specific improvements to boost ATS score
      - section_scores: object with scores for each resume section (summary, experience, skills, education, projects)
      - overall_verdict: one of "ats_optimized", "needs_improvement", "major_rework_needed"

      Be specific and actionable. Reference Indian tech hiring standards.
      Return well-structured JSON only.
    PROMPT
  end

  def offer_analysis_prompt(offer_data, user_profile, market_data)
    <<~PROMPT
      You are an expert compensation analyst for Indian tech professionals.

      Candidate profile:
      - Role: #{user_profile[:role]}
      - Experience: #{user_profile[:experience_years]} years
      - City: #{user_profile[:city]}
      - Current Salary: ₹#{user_profile[:current_salary]} per annum

      Offer details:
      - Company: #{offer_data[:company_name]}
      - Offered Role: #{offer_data[:offer_role]}
      - Base Salary: ₹#{offer_data[:base_salary]} per annum
      - Total CTC: ₹#{offer_data[:total_ctc]} per annum
      - Components: #{offer_data[:components]}

      Market context:
      - Market Median: ₹#{market_data[:median_salary]} per annum
      - Market Max: ₹#{market_data[:max_salary]} per annum

      Analyze this offer and provide:
      - offer_score: overall score (0-100)
      - verdict: one of "strong_accept", "accept", "negotiate", "caution", "decline"
      - salary_analysis: comparison with market (above/below/at market, percentage)
      - ctc_breakdown_analysis: analysis of CTC components (what's real take-home vs variable)
      - red_flags: array of concerns with the offer (e.g., "High variable component", "Below market base")
      - green_flags: array of positives (e.g., "Above market base", "Good ESOP component")
      - recommendations: array of 4-5 specific actionable recommendations
      - estimated_take_home: estimated monthly take-home after tax and deductions
      - growth_potential: assessment of growth potential at this company/role

      Be specific to Indian tax structure and tech compensation norms.
      Return well-structured JSON only.
    PROMPT
  end

  def job_recommendations_prompt(user_profile, user_skills)
    <<~PROMPT
      You are an expert job market analyst for the Indian tech industry.

      Candidate profile:
      - Role: #{user_profile[:role]}
      - City: #{user_profile[:city]}
      - Experience: #{user_profile[:experience_years]} years
      - Current Salary: ₹#{user_profile[:current_salary]} per annum
      - Skills: #{user_skills.join(', ')}

      Generate 8-10 realistic job recommendations that match this profile.
      For each job provide:
      - title: job title
      - company_name: realistic Indian tech company name
      - location: city in India
      - job_type: one of "full_time", "remote", "hybrid"
      - min_salary: minimum annual salary in INR
      - max_salary: maximum annual salary in INR
      - description: 2-3 sentence job description
      - required_skills: array of required skills
      - experience_range: e.g., "3-5" or "5+"
      - match_score: 1-100 how well this matches the candidate
      - match_reasons: array of 2-3 reasons why this is a good match
      - matched_skills: skills the candidate already has for this role
      - missing_skills: skills the candidate would need to learn

      Focus on realistic opportunities in the Indian tech market.
      Include a mix of stretch roles and comfortable matches.
      Return well-structured JSON only.
    PROMPT
  end

  def daily_challenge_prompt(challenge_type, difficulty, role)
    type_label = { "dsa" => "Data Structures & Algorithms", "system_design" => "System Design", "behavioral" => "Behavioral" }[challenge_type] || challenge_type
    <<~PROMPT
      You are a senior technical interviewer creating a daily interview challenge.

      Generate ONE #{difficulty} #{type_label} interview question for a #{role}.

      Provide:
      - question: a clear, specific interview question
      - context: 1-2 sentences explaining what this question tests
      - hints: array of 2 progressive hints (don't give away the answer)
      - ideal_answer: a comprehensive model answer (4-6 sentences)

      Make it realistic for Indian tech interviews. Return well-structured JSON only.
    PROMPT
  end

  def daily_challenge_feedback_prompt(question_data, user_answer)
    <<~PROMPT
      You are a senior technical interviewer evaluating a candidate's answer to a daily challenge.

      Question: #{question_data["question"]}
      Context: #{question_data["context"]}
      Ideal Answer: #{question_data["ideal_answer"]}

      Candidate's Answer: #{user_answer}

      Evaluate and provide:
      - score: number from 1-10
      - feedback: 2-3 sentences of constructive feedback
      - strengths: array of 1-3 things done well
      - improvements: array of 1-3 areas to improve

      Be encouraging but honest. Return well-structured JSON only.
    PROMPT
  end

  def interview_debrief_prompt(company_name, role, questions_text, user_notes)
    <<~PROMPT
      You are an expert interview coach analyzing a candidate's real interview experience.

      Company: #{company_name}
      Role: #{role}
      Questions asked:
      - #{questions_text}

      Candidate's notes: #{user_notes.presence || "None provided"}

      Analyze this interview and provide:
      - overall_assessment: 2-3 sentence assessment of the interview difficulty and pattern
      - difficulty_rating: one of "Easy", "Medium", "Hard", "Very Hard"
      - question_analysis: for each question provide category, difficulty, a model_answer (3-5 sentences), and specific tips
      - strengths_detected: array of 2-3 strengths this interview tested
      - areas_to_improve: array of 2-3 areas to focus on
      - prep_recommendations: array of 3-4 specific study recommendations
      - company_insights: 2-3 sentences about this company's interview pattern/culture

      Be specific to #{company_name} and the Indian tech market. Return well-structured JSON only.
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
