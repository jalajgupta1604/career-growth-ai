class DailyChallenge < ApplicationRecord
  has_many :challenge_attempts, dependent: :destroy

  validates :challenge_date, presence: true, uniqueness: true
  validates :challenge_type, presence: true, inclusion: { in: %w[dsa system_design behavioral] }
  validates :difficulty, inclusion: { in: %w[easy medium hard] }

  scope :today, -> { where(challenge_date: Date.current) }

  def self.for_today
    today.first
  end

  def attempted_by?(user)
    challenge_attempts.exists?(user_id: user.id)
  end

  def attempt_by(user)
    challenge_attempts.find_by(user_id: user.id)
  end

  def total_attempts
    challenge_attempts.count
  end

  def average_score
    challenge_attempts.average(:score)&.round(1) || 0
  end
end
