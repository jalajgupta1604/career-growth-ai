class AnalyticsEvent < ApplicationRecord
  belongs_to :user, optional: true

  validates :event_type, presence: true

  scope :recent, -> { order(created_at: :desc) }
  scope :by_type, ->(type) { where(event_type: type) }
  scope :in_period, ->(from, to) { where(created_at: from..to) }

  EVENT_TYPES = %w[
    page_view signup onboarding_complete report_generated subscription_started
    subscription_cancelled mock_interview_completed challenge_completed
    resume_uploaded job_applied community_post_created feature_used
  ].freeze

  def self.track(event_type:, user: nil, resource: nil, properties: {}, request: nil)
    create!(
      event_type: event_type,
      user: user,
      resource_type: resource&.class&.name,
      resource_id: resource&.id,
      properties: properties,
      session_id: request&.session&.id,
      ip_address: request&.remote_ip,
      user_agent: request&.user_agent
    )
  end

  def self.funnel(steps, period: 30.days.ago..Time.current)
    steps.map do |step|
      { step: step, count: in_period(period.first, period.last).by_type(step).select(:user_id).distinct.count }
    end
  end

  def self.cohort_retention(months_back: 6)
    (0...months_back).map do |m|
      cohort_start = m.months.ago.beginning_of_month
      cohort_end = cohort_start.end_of_month
      cohort_users = User.where(created_at: cohort_start..cohort_end).pluck(:id)
      next { month: cohort_start.strftime("%b %Y"), size: 0, retention: [] } if cohort_users.empty?

      retention = (0..([months_back - m - 1, 5].min)).map do |month_offset|
        period_start = (cohort_start + month_offset.months).beginning_of_month
        period_end = period_start.end_of_month
        active = in_period(period_start, period_end).where(user_id: cohort_users).select(:user_id).distinct.count
        (active.to_f / cohort_users.size * 100).round(1)
      end

      { month: cohort_start.strftime("%b %Y"), size: cohort_users.size, retention: retention }
    end.reverse
  end
end
