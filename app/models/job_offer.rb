class JobOffer < ApplicationRecord
  belongs_to :job_application
  belongs_to :employer_profile
  belongs_to :candidate, class_name: "User"

  validates :status, presence: true

  scope :recent, -> { order(created_at: :desc) }
  scope :pending, -> { where(status: "sent") }
  scope :active, -> { where(status: %w[draft sent]) }

  STATUSES = %w[draft sent accepted declined expired withdrawn].freeze

  def total_compensation
    (base_salary.to_f + variable_pay.to_f + equity_value.to_f)
  end

  def send_to_candidate!
    update!(status: "sent", sent_at: Time.current, expires_at: 14.days.from_now)
    NotificationService.notify(
      user: candidate,
      title: "You received a job offer!",
      body: "#{employer_profile.company_name} has sent you an offer for #{designation}.",
      category: "career",
      action_url: "/job_postings/#{job_application.job_posting_id}"
    )
  end

  def accept!
    update!(status: "accepted", accepted_at: Time.current)
    job_application.update!(status: "hired") if job_application.respond_to?(:status)
  end

  def decline!(reason = nil)
    update!(status: "declined", declined_at: Time.current, decline_reason: reason)
  end

  def expired?
    expires_at.present? && expires_at < Time.current && status == "sent"
  end

  def ctc_in_lakhs
    (total_compensation / 100000.0).round(1)
  end
end
