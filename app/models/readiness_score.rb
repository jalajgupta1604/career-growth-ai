class ReadinessScore < ApplicationRecord
  belongs_to :user

  scope :latest_for, ->(user) { where(user: user).order(calculated_at: :desc).first }
  scope :history_for, ->(user) { where(user: user).order(calculated_at: :desc).limit(30) }
end
