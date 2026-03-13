class SpacedRepetitionService
  def initialize(user)
    @user = user
  end

  def due_items(limit = 20)
    @user.revision_items.due.weakest.limit(limit)
  end

  def revision_session(limit = 5)
    @user.revision_items.due_today.weakest.limit(limit)
  end

  def review_item!(item, quality)
    item.review!(quality)
  end

  def add_from_challenge(challenge_attempt)
    return unless challenge_attempt.daily_challenge

    challenge = challenge_attempt.daily_challenge
    question_data = challenge.question_data || {}
    topic = challenge.challenge_type || "general"

    item = @user.revision_items.find_or_initialize_by(
      source_type: "challenge",
      source_id: challenge.id
    )

    item.assign_attributes(
      topic: topic,
      difficulty: difficulty_from_score(challenge_attempt.score),
      question_data: question_data,
      answer_data: { user_answer: challenge_attempt.answer, score: challenge_attempt.score },
      next_review_at: item.new_record? ? next_review_from_score(challenge_attempt.score) : item.next_review_at
    )

    item.save!
    item
  end

  def add_from_mock_interview(mock_interview)
    return unless mock_interview.completed? && mock_interview.questions_data.present?

    mock_interview.questions_data.each_with_index do |q, i|
      feedback = mock_interview.feedback_data&.dig(i.to_s) || {}
      score = feedback["score"] || 5

      item = @user.revision_items.find_or_initialize_by(
        source_type: "mock_interview",
        source_id: "#{mock_interview.id}_#{i}".to_i
      )

      item.assign_attributes(
        topic: q["category"] || mock_interview.interview_type,
        difficulty: mock_interview.difficulty,
        question_data: q,
        answer_data: feedback,
        next_review_at: item.new_record? ? next_review_from_score(score) : item.next_review_at
      )

      item.save!
    end
  end

  def weakness_heatmap
    topics = @user.revision_items.group(:topic).select(
      "topic",
      "COUNT(*) as total_count",
      "AVG(easiness_factor) as avg_ef",
      "AVG(correct_streak) as avg_streak",
      "SUM(CASE WHEN easiness_factor < 1.8 THEN 1 ELSE 0 END) as weak_count",
      "SUM(CASE WHEN easiness_factor > 2.5 AND correct_streak >= 5 THEN 1 ELSE 0 END) as strong_count"
    )

    topics.map do |t|
      weak_ratio = t.total_count > 0 ? t.weak_count.to_f / t.total_count : 0
      {
        topic: t.topic,
        total: t.total_count,
        weak: t.weak_count,
        strong: t.strong_count,
        avg_easiness: t.avg_ef&.round(2),
        strength_label: weak_ratio > 0.5 ? "needs_work" : (weak_ratio > 0.2 ? "improving" : "strong"),
        heat_level: (weak_ratio * 100).round
      }
    end.sort_by { |t| -t[:heat_level] }
  end

  def stats
    items = @user.revision_items
    {
      total_items: items.count,
      due_today: items.due_today.count,
      weak_items: items.where("easiness_factor < 1.8").count,
      strong_items: items.where("easiness_factor > 2.5 AND correct_streak >= 5").count,
      total_reviews: items.sum(:total_attempts),
      accuracy: items.count > 0 ? (items.sum(:correct_attempts).to_f / [items.sum(:total_attempts), 1].max * 100).round : 0
    }
  end

  private

  def difficulty_from_score(score)
    return "easy" if score.to_i >= 8
    return "hard" if score.to_i <= 4
    "medium"
  end

  def next_review_from_score(score)
    if score.to_i >= 8
      Time.current + 3.days
    elsif score.to_i >= 5
      Time.current + 1.day
    else
      Time.current + 4.hours
    end
  end
end
