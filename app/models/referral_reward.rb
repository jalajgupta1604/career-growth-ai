class ReferralReward < ApplicationRecord
  belongs_to :user
  belongs_to :referred_user, class_name: "User"

  validates :reward_type, presence: true
  validates :user_id, uniqueness: { scope: :referred_user_id }

  scope :pending, -> { where(status: "pending") }
  scope :credited, -> { where(status: "credited") }
  scope :recent, -> { order(created_at: :desc) }

  def credit!
    update!(status: "credited", credited_at: Time.current)
  end
end
