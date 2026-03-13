class RevisionItem < ApplicationRecord
  belongs_to :user

  validates :source_type, presence: true, inclusion: { in: %w[challenge mock_interview lesson] }
  validates :topic, presence: true
  validates :difficulty, inclusion: { in: %w[easy medium hard] }

  scope :due, -> { where("next_review_at <= ?", Time.current) }
  scope :due_today, -> { where("next_review_at <= ?", Time.current.end_of_day) }
  scope :by_topic, ->(topic) { where(topic: topic) }
  scope :weakest, -> { order(easiness_factor: :asc, correct_streak: :asc) }
  scope :recent, -> { order(last_reviewed_at: :desc) }

  # SM-2 Algorithm implementation
  def review!(quality)
    # quality: 0-5 (0=complete fail, 5=perfect recall)
    quality = quality.to_i.clamp(0, 5)

    self.total_attempts += 1
    self.correct_attempts += 1 if quality >= 3
    self.last_reviewed_at = Time.current

    if quality >= 3
      self.correct_streak += 1
      case repetitions
      when 0 then self.interval = 1
      when 1 then self.interval = 6
      else self.interval = (interval * easiness_factor).round
      end
      self.repetitions += 1
    else
      self.correct_streak = 0
      self.repetitions = 0
      self.interval = 1
    end

    self.easiness_factor = [1.3, easiness_factor + (0.1 - (5 - quality) * (0.08 + (5 - quality) * 0.02))].max
    self.next_review_at = Time.current + interval.days

    save!
  end

  def accuracy_percentage
    return 0 if total_attempts.zero?
    (correct_attempts.to_f / total_attempts * 100).round
  end

  def strength
    return "weak" if easiness_factor < 1.8 || correct_streak < 2
    return "strong" if easiness_factor > 2.5 && correct_streak >= 5
    "medium"
  end

  def overdue?
    next_review_at < Time.current
  end

  def days_until_review
    return 0 if overdue?
    ((next_review_at - Time.current) / 1.day).ceil
  end
end
