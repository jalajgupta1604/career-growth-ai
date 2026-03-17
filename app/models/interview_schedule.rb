class InterviewSchedule < ApplicationRecord
  belongs_to :job_application
  belongs_to :employer_profile
  belongs_to :candidate, class_name: "User"

  validates :title, :scheduled_at, presence: true

  scope :upcoming, -> { where(status: "confirmed").where("scheduled_at > ?", Time.current).order(scheduled_at: :asc) }
  scope :pending, -> { where(status: "pending").order(scheduled_at: :asc) }
  scope :past, -> { where("scheduled_at < ?", Time.current).order(scheduled_at: :desc) }
  scope :recent, -> { order(created_at: :desc) }

  ROUND_TYPES = %w[screening technical behavioral culture_fit system_design final].freeze
  STATUSES = %w[pending confirmed rescheduled completed cancelled no_show].freeze

  def confirm!
    update!(status: "confirmed", confirmed_at: Time.current)
  end

  def complete!(feedback: nil, rating: nil)
    update!(status: "completed", completed_at: Time.current, interviewer_feedback: feedback, rating: rating)
  end

  def cancel!
    update!(status: "cancelled", cancelled_at: Time.current)
  end

  def upcoming?
    scheduled_at > Time.current && status.in?(%w[pending confirmed])
  end

  def time_display
    scheduled_at.strftime("%b %d, %Y at %I:%M %p")
  end
end
