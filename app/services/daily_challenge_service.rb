class DailyChallengeService
  CHALLENGE_TYPES = %w[dsa system_design behavioral].freeze
  DIFFICULTIES = %w[easy medium hard].freeze

  def initialize(user)
    @user = user
  end

  def today_challenge
    challenge = DailyChallenge.for_today
    challenge || generate_today_challenge
  end

  def submit_answer(challenge, answer_text)
    return nil if challenge.attempted_by?(@user)

    question = challenge.question_data
    feedback = evaluate_answer(question, answer_text)
    score = feedback["score"] || 5

    attempt = ChallengeAttempt.create!(
      user: @user,
      daily_challenge: challenge,
      answer_data: { answer: answer_text, feedback: feedback },
      score: score,
      completed_at: Time.current
    )

    streak = @user.user_streak || @user.create_user_streak
    streak.record_completion!

    attempt
  end

  def streak_data
    streak = @user.user_streak || @user.build_user_streak
    {
      current_streak: streak.current_streak,
      longest_streak: streak.longest_streak,
      active_today: streak.active_today?,
      streak_alive: streak.streak_alive?
    }
  end

  def recent_attempts(limit = 7)
    @user.challenge_attempts
         .includes(:daily_challenge)
         .order(created_at: :desc)
         .limit(limit)
  end

  private

  def generate_today_challenge
    today = Date.current
    challenge_type = CHALLENGE_TYPES[today.yday % CHALLENGE_TYPES.size]
    difficulty = DIFFICULTIES[today.yday % DIFFICULTIES.size]

    question_data = generate_question(challenge_type, difficulty)

    DailyChallenge.create!(
      challenge_date: today,
      challenge_type: challenge_type,
      difficulty: difficulty,
      question_data: question_data
    )
  rescue ActiveRecord::RecordNotUnique
    DailyChallenge.for_today
  end

  def generate_question(challenge_type, difficulty)
    role = @user.role || "Software Developer"
    prompt = GeminiPrompts.daily_challenge_prompt(challenge_type, difficulty, role)
    result = GeminiClient.new.generate(prompt, response_schema: challenge_schema)

    if result && result["question"].present?
      result
    else
      fallback_question(challenge_type, difficulty)
    end
  rescue => e
    Rails.logger.error("Daily challenge generation failed: #{e.message}")
    fallback_question(challenge_type, difficulty)
  end

  def evaluate_answer(question, answer_text)
    prompt = GeminiPrompts.daily_challenge_feedback_prompt(question, answer_text)
    result = GeminiClient.new.generate(prompt, response_schema: feedback_schema)
    result || { "score" => 5, "feedback" => "Unable to evaluate at this time.", "strengths" => [], "improvements" => [] }
  rescue => e
    Rails.logger.error("Challenge evaluation failed: #{e.message}")
    { "score" => 5, "feedback" => "Unable to evaluate at this time.", "strengths" => [], "improvements" => [] }
  end

  def fallback_question(challenge_type, difficulty)
    questions = {
      "dsa" => {
        "question" => "Given an array of integers, find two numbers such that they add up to a specific target. What is the most efficient approach?",
        "context" => "This is a classic problem testing hash map usage for O(n) lookup.",
        "hints" => ["Think about what complement you need for each number", "A hash map can store seen values"],
        "ideal_answer" => "Use a hash map to store each number as you iterate. For each element, check if (target - current) exists in the map. Time: O(n), Space: O(n)."
      },
      "system_design" => {
        "question" => "Design a URL shortening service like bit.ly. What are the key components and how would you handle scale?",
        "context" => "Tests understanding of hashing, database design, and caching.",
        "hints" => ["Consider base62 encoding", "Think about read-heavy vs write-heavy patterns"],
        "ideal_answer" => "Use base62 encoding of an auto-increment ID or hash. Store mappings in a database with Redis cache for hot URLs. Use a load balancer for horizontal scaling. Handle collisions with retry or counter-based approach."
      },
      "behavioral" => {
        "question" => "Tell me about a time you had to deliver a project under a very tight deadline. How did you handle it?",
        "context" => "Tests time management, prioritization, and communication skills.",
        "hints" => ["Use the STAR method", "Focus on what YOU specifically did"],
        "ideal_answer" => "Structure using STAR: describe the situation and constraints, your specific task, actions you took (prioritization, delegation, communication with stakeholders), and the measurable result achieved."
      }
    }
    questions[challenge_type] || questions["dsa"]
  end

  def challenge_schema
    {
      type: "OBJECT",
      properties: {
        question: { type: "STRING" },
        context: { type: "STRING" },
        hints: { type: "ARRAY", items: { type: "STRING" } },
        ideal_answer: { type: "STRING" }
      }
    }
  end

  def feedback_schema
    {
      type: "OBJECT",
      properties: {
        score: { type: "INTEGER" },
        feedback: { type: "STRING" },
        strengths: { type: "ARRAY", items: { type: "STRING" } },
        improvements: { type: "ARRAY", items: { type: "STRING" } }
      }
    }
  end
end
