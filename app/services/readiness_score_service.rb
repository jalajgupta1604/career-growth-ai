class ReadinessScoreService
  def initialize(user)
    @user = user
  end

  def calculate
    lesson = lesson_score
    mock = mock_interview_score
    streak = streak_score
    overall = (lesson * 0.4 + mock * 0.35 + streak * 0.25).round(1)

    ReadinessScore.create!(
      user: @user,
      overall_score: overall,
      category_scores: category_breakdown,
      mock_interview_score: mock,
      lesson_score: lesson,
      streak_score: streak,
      calculated_at: Time.current
    )
  end

  def current_score
    ReadinessScore.where(user: @user).order(calculated_at: :desc).first
  end

  def score_history
    ReadinessScore.where(user: @user).order(calculated_at: :desc).limit(30)
  end

  private

  def lesson_score
    total = PrepLesson.count
    return 0.0 if total.zero?

    completed = @user.lesson_progresses.where(status: :completed).count
    (completed.to_f / total * 100).round(1)
  end

  def mock_interview_score
    completed = @user.mock_interviews.where(status: :completed)
    return 0.0 if completed.empty?

    avg = completed.average(:overall_score) || 0
    (avg * 10).clamp(0, 100).round(1)
  end

  def streak_score
    streak = @user.user_streak
    return 0.0 unless streak

    # 30-day streak = 100%
    (streak.current_streak.to_f / 30 * 100).clamp(0, 100).round(1)
  end

  def category_breakdown
    PrepCategory.ordered.each_with_object({}) do |cat, hash|
      total = cat.prep_lessons.count
      next if total.zero?

      completed = cat.completed_count_for(@user)
      hash[cat.name] = (completed.to_f / total * 100).round(1)
    end
  end
end
