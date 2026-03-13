class PeerPracticeSession < ApplicationRecord
  belongs_to :user
  belongs_to :partner, class_name: "User", optional: true

  enum :status, { pending: 0, matched: 1, scheduled: 2, in_progress: 3, completed: 4, cancelled: 5 }
  enum :session_type, { mock_interview: "mock_interview", pair_coding: "pair_coding", system_design: "system_design" }, prefix: true

  scope :recent, -> { order(created_at: :desc) }
  scope :available, -> { where(status: :pending, partner_id: nil) }
  scope :upcoming, -> { where(status: [:matched, :scheduled]).where("scheduled_at > ?", Time.current).order(scheduled_at: :asc) }

  def partner_name
    partner&.full_name || "Waiting for match..."
  end

  def can_join?(join_user)
    pending? && partner_id.nil? && user_id != join_user.id
  end
end
