class ImpersonationLog < ApplicationRecord
  belongs_to :admin, class_name: "User"
  belongs_to :target_user, class_name: "User"

  validates :reason, presence: true

  scope :active, -> { where(ended_at: nil) }
  scope :recent, -> { order(created_at: :desc) }

  def end!
    update!(ended_at: Time.current)
  end

  def active?
    ended_at.nil?
  end

  def duration_minutes
    return nil if ended_at.nil?
    ((ended_at - started_at) / 60).round(1)
  end
end
