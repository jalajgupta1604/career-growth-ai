class AdaptiveDifficultyService
  LEVELS = %w[beginner intermediate advanced expert].freeze

  def initialize(user)
    @user = user
  end

  def recommended_difficulty
    avg = average_performance
    if avg >= 85 then "expert"
    elsif avg >= 65 then "advanced"
    elsif avg >= 40 then "intermediate"
    else "beginner"
    end
  end

  def next_challenge_difficulty
    recent = @user.challenge_attempts.order(created_at: :desc).limit(5)
    return "intermediate" if recent.empty?

    correct = recent.count { |a| a.correct }
    if correct >= 4
      level_up(current_level)
    elsif correct <= 1
      level_down(current_level)
    else
      current_level
    end
  end

  def coding_problem_difficulty
    submissions = @user.code_submissions.order(created_at: :desc).limit(10)
    return "beginner" if submissions.empty?

    pass_rate = submissions.count { |s| s.passed }.to_f / submissions.size
    if pass_rate >= 0.8 then "advanced"
    elsif pass_rate >= 0.5 then "intermediate"
    else "beginner"
    end
  end

  private

  def average_performance
    attempts = @user.challenge_attempts.where("created_at > ?", 30.days.ago)
    return 50 if attempts.empty?
    attempts.count { |a| a.correct }.to_f / attempts.count * 100
  end

  def current_level
    @user.notification_preferences&.dig("difficulty_level") || "intermediate"
  end

  def level_up(level)
    idx = LEVELS.index(level) || 1
    LEVELS[[idx + 1, LEVELS.length - 1].min]
  end

  def level_down(level)
    idx = LEVELS.index(level) || 1
    LEVELS[[idx - 1, 0].max]
  end
end
