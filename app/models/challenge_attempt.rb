class ChallengeAttempt < ApplicationRecord
  belongs_to :user
  belongs_to :daily_challenge

  validates :user_id, uniqueness: { scope: :daily_challenge_id, message: "has already attempted this challenge" }

  scope :recent, -> { order(created_at: :desc) }

  def correct?
    score.present? && score >= 7
  end
end
