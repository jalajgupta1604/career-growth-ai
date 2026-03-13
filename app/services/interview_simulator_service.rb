class InterviewSimulatorService
  COMPANY_STYLES = {
    "google" => { name: "Google", focus: "problem-solving, algorithmic thinking, Googleyness", rounds: "Phone screen → Technical × 2 → System Design → Behavioral" },
    "amazon" => { name: "Amazon", focus: "Leadership Principles, scalable systems, customer obsession", rounds: "OA → Phone → Loop (4-5 rounds)" },
    "microsoft" => { name: "Microsoft", focus: "coding fundamentals, system design, growth mindset", rounds: "Phone → On-site (4 rounds)" },
    "flipkart" => { name: "Flipkart", focus: "DSA, system design for e-commerce scale, problem solving", rounds: "Machine Coding → DSA → System Design → Hiring Manager" },
    "razorpay" => { name: "Razorpay", focus: "fintech domain, payments systems, clean code", rounds: "DSA → System Design → Culture Fit → Hiring Manager" },
    "swiggy" => { name: "Swiggy", focus: "real-time systems, geo-distributed architecture, DSA", rounds: "DSA → Machine Coding → System Design → HR" },
    "general" => { name: "General", focus: "well-rounded technical and behavioral skills", rounds: "Standard interview process" }
  }.freeze

  def initialize(user)
    @user = user
  end

  def create_simulation(interview_type:, difficulty:, company_style: "general")
    resume = @user.resumes.where(parsing_status: :completed).order(created_at: :desc).first
    user_skills = resume&.parsed_data&.dig("skills") || []
    role = @user.role || "Software Developer"

    user_profile = {
      experience_years: @user.experience_years,
      city: @user.city,
      skills: user_skills
    }

    company = COMPANY_STYLES[company_style] || COMPANY_STYLES["general"]

    prompt = GeminiPrompts.simulator_interview_prompt(
      interview_type, difficulty, role, user_profile, company
    )
    result = GeminiClient.new.generate(prompt, response_schema: questions_schema)

    questions = if result
      (result["questions"] || result).first(5)
    else
      MockInterviewService.new(@user).send(:fallback_questions, interview_type, difficulty, role)
    end

    @user.mock_interviews.create!(
      interview_type: interview_type,
      difficulty: difficulty,
      target_role: role,
      company_style: company_style,
      simulator_mode: true,
      status: :in_progress,
      questions_data: questions,
      follow_up_data: {},
      total_questions: questions.size,
      started_at: Time.current
    )
  end

  def submit_answer_with_follow_up(interview, answer_text)
    return nil if interview.finished?

    question = interview.current_question
    return nil unless question

    role = interview.target_role || @user.role || "Software Developer"
    company = COMPANY_STYLES[interview.company_style] || COMPANY_STYLES["general"]

    # Get feedback with follow-up question
    prompt = GeminiPrompts.simulator_feedback_prompt(
      question["question"], answer_text, role, company
    )
    feedback = GeminiClient.new.generate(prompt, response_schema: follow_up_feedback_schema)

    feedback ||= {
      "score" => 5,
      "strengths" => ["Answer provided"],
      "improvements" => ["Could be more detailed"],
      "model_answer" => "N/A",
      "tip" => "Practice elaborating on your answers.",
      "follow_up_question" => nil,
      "communication_score" => 5,
      "technical_depth_score" => 5
    }

    responses = interview.responses_data || []
    responses << {
      "question_index" => interview.current_question_index,
      "answer" => answer_text,
      "feedback" => feedback,
      "submitted_at" => Time.current.iso8601
    }

    # Store follow-up data
    follow_ups = interview.follow_up_data || {}
    if feedback["follow_up_question"].present?
      follow_ups[interview.current_question_index.to_s] = {
        "question" => feedback["follow_up_question"],
        "asked_at" => Time.current.iso8601
      }
    end

    interview.update!(
      responses_data: responses,
      follow_up_data: follow_ups,
      answered_questions: interview.answered_questions + 1
    )

    if interview.finished?
      generate_scorecard(interview)
    end

    feedback
  end

  def generate_scorecard(interview)
    responses = interview.responses_data || []
    scores = responses.map { |r| r.dig("feedback", "score").to_f }
    comm_scores = responses.map { |r| r.dig("feedback", "communication_score").to_f }.reject(&:zero?)
    tech_scores = responses.map { |r| r.dig("feedback", "technical_depth_score").to_f }.reject(&:zero?)

    overall = scores.any? ? (scores.sum / scores.size).round(1) : 0
    communication = comm_scores.any? ? (comm_scores.sum / comm_scores.size).round(1) : overall
    technical_depth = tech_scores.any? ? (tech_scores.sum / tech_scores.size).round(1) : overall

    # Category breakdown
    categories = responses.each_with_object({}) do |r, cats|
      idx = r["question_index"].to_i
      question = interview.questions_data[idx]
      cat = question&.dig("category") || "General"
      cats[cat] ||= []
      cats[cat] << r.dig("feedback", "score").to_f
    end

    category_scores = categories.transform_values { |scores| (scores.sum / scores.size).round(1) }

    company = COMPANY_STYLES[interview.company_style] || COMPANY_STYLES["general"]

    scorecard = {
      "overall_score" => overall,
      "communication_score" => communication,
      "technical_depth_score" => technical_depth,
      "category_scores" => category_scores,
      "total_questions" => interview.total_questions,
      "company" => company[:name],
      "verdict" => verdict_for(overall),
      "strengths" => top_strengths(responses),
      "improvements" => top_improvements(responses),
      "hire_probability" => hire_probability(overall, communication, technical_depth)
    }

    interview.update!(
      status: :completed,
      overall_score: overall,
      feedback_data: scorecard,
      scorecard_data: scorecard,
      completed_at: Time.current
    )
  end

  private

  def verdict_for(score)
    return "Strong Hire" if score >= 8
    return "Hire" if score >= 6.5
    return "Lean Hire" if score >= 5
    return "Lean No Hire" if score >= 3.5
    "No Hire"
  end

  def hire_probability(overall, comm, tech)
    weighted = overall * 0.5 + comm * 0.25 + tech * 0.25
    [(weighted * 10).round, 100].min
  end

  def top_strengths(responses)
    responses.flat_map { |r| r.dig("feedback", "strengths") || [] }.tally.sort_by { |_, v| -v }.first(3).map(&:first)
  end

  def top_improvements(responses)
    responses.flat_map { |r| r.dig("feedback", "improvements") || [] }.tally.sort_by { |_, v| -v }.first(3).map(&:first)
  end

  def questions_schema
    {
      type: "OBJECT",
      properties: {
        questions: {
          type: "ARRAY",
          items: {
            type: "OBJECT",
            properties: {
              question: { type: "STRING" },
              category: { type: "STRING" },
              expected_time_minutes: { type: "INTEGER" },
              evaluation_criteria: { type: "ARRAY", items: { type: "STRING" } },
              ideal_answer_outline: { type: "ARRAY", items: { type: "STRING" } }
            }
          }
        }
      }
    }
  end

  def follow_up_feedback_schema
    {
      type: "OBJECT",
      properties: {
        score: { type: "INTEGER" },
        strengths: { type: "ARRAY", items: { type: "STRING" } },
        improvements: { type: "ARRAY", items: { type: "STRING" } },
        model_answer: { type: "STRING" },
        tip: { type: "STRING" },
        follow_up_question: { type: "STRING" },
        communication_score: { type: "INTEGER" },
        technical_depth_score: { type: "INTEGER" }
      }
    }
  end
end
