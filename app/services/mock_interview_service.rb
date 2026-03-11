class MockInterviewService
  def initialize(user)
    @user = user
  end

  def create_interview(interview_type:, difficulty:)
    resume = @user.resumes.where(parsing_status: :completed).order(created_at: :desc).first
    user_skills = resume&.parsed_data&.dig("skills") || []
    role = @user.role || "Software Developer"

    user_profile = {
      experience_years: @user.experience_years,
      city: @user.city,
      skills: user_skills
    }

    prompt = GeminiPrompts.mock_interview_prompt(interview_type, difficulty, role, user_profile)
    result = GeminiClient.new.generate(prompt, response_schema: questions_schema)

    questions = if result
      (result["questions"] || result).first(5)
    else
      fallback_questions(interview_type, difficulty, role)
    end

    @user.mock_interviews.create!(
      interview_type: interview_type,
      difficulty: difficulty,
      target_role: role,
      status: :in_progress,
      questions_data: questions,
      total_questions: questions.size,
      started_at: Time.current
    )
  end

  def submit_answer(interview, answer_text)
    return nil if interview.finished?

    question = interview.current_question
    return nil unless question

    role = interview.target_role || @user.role || "Software Developer"
    prompt = GeminiPrompts.mock_interview_feedback_prompt(question["question"], answer_text, role)
    feedback = GeminiClient.new.generate(prompt, response_schema: feedback_schema)

    feedback ||= {
      "score" => 5,
      "strengths" => ["Answer provided"],
      "improvements" => ["Could be more detailed"],
      "model_answer" => "N/A",
      "tip" => "Practice elaborating on your answers."
    }

    responses = interview.responses_data || []
    responses << {
      "question_index" => interview.current_question_index,
      "answer" => answer_text,
      "feedback" => feedback,
      "submitted_at" => Time.current.iso8601
    }

    interview.update!(
      responses_data: responses,
      answered_questions: interview.answered_questions + 1
    )

    if interview.finished?
      finalize_interview(interview)
    end

    feedback
  end

  def finalize_interview(interview)
    responses = interview.responses_data || []
    scores = responses.map { |r| r.dig("feedback", "score").to_f }
    overall = scores.any? ? (scores.sum / scores.size).round(1) : 0

    feedback_summary = {
      "overall_score" => overall,
      "total_questions" => interview.total_questions,
      "average_score" => overall,
      "strongest_area" => strongest_area(responses),
      "weakest_area" => weakest_area(responses)
    }

    interview.update!(
      status: :completed,
      overall_score: overall,
      feedback_data: feedback_summary,
      completed_at: Time.current
    )
  end

  def dashboard_data
    interviews = @user.mock_interviews.recent.limit(10)
    completed = @user.mock_interviews.completed
    {
      recent_interviews: interviews,
      total_completed: completed.count,
      average_score: completed.average(:overall_score)&.round(1) || 0,
      best_score: completed.maximum(:overall_score)&.round(1) || 0
    }
  end

  private

  def strongest_area(responses)
    best = responses.max_by { |r| r.dig("feedback", "score").to_f }
    return nil unless best
    idx = best["question_index"].to_i
    "Question #{idx + 1}"
  end

  def weakest_area(responses)
    worst = responses.min_by { |r| r.dig("feedback", "score").to_f }
    return nil unless worst
    idx = worst["question_index"].to_i
    "Question #{idx + 1}"
  end

  def fallback_questions(interview_type, difficulty, role)
    [
      { "question" => "Tell me about a challenging project you worked on recently and how you handled it.", "category" => "Behavioral", "expected_time_minutes" => 5, "evaluation_criteria" => ["Problem identification", "Approach taken", "Outcome achieved"], "ideal_answer_outline" => ["Describe the context", "Explain the challenge", "Detail your approach", "Share the result"] },
      { "question" => "How would you design a URL shortening service like bit.ly?", "category" => "System Design", "expected_time_minutes" => 8, "evaluation_criteria" => ["Requirements gathering", "High-level design", "Scalability considerations"], "ideal_answer_outline" => ["Clarify requirements", "API design", "Database schema", "Scaling strategy"] },
      { "question" => "What is the difference between process and thread? When would you use each?", "category" => "CS Fundamentals", "expected_time_minutes" => 3, "evaluation_criteria" => ["Clear definitions", "Use cases", "Trade-offs"], "ideal_answer_outline" => ["Define process vs thread", "Memory sharing", "When to use each", "Real-world examples"] },
      { "question" => "Given an array of integers, find two numbers that add up to a target sum. Explain your approach.", "category" => "Data Structures", "expected_time_minutes" => 5, "evaluation_criteria" => ["Algorithm choice", "Time complexity", "Edge cases"], "ideal_answer_outline" => ["Brute force approach", "Optimized hash map approach", "Time/space complexity", "Edge cases"] },
      { "question" => "How do you handle disagreements with team members on technical decisions?", "category" => "Behavioral", "expected_time_minutes" => 4, "evaluation_criteria" => ["Communication skills", "Conflict resolution", "Team orientation"], "ideal_answer_outline" => ["Listen first", "Present data-driven arguments", "Find compromise", "Document decisions"] }
    ]
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

  def feedback_schema
    {
      type: "OBJECT",
      properties: {
        score: { type: "INTEGER" },
        strengths: { type: "ARRAY", items: { type: "STRING" } },
        improvements: { type: "ARRAY", items: { type: "STRING" } },
        model_answer: { type: "STRING" },
        tip: { type: "STRING" }
      }
    }
  end
end
