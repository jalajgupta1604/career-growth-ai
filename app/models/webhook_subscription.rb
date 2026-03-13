class WebhookSubscription < ApplicationRecord
  belongs_to :user

  validates :url, presence: true, format: { with: URI::DEFAULT_PARSER.make_regexp(%w[http https]), message: "must be a valid URL" }

  scope :active, -> { where(active: true) }
  scope :for_event, ->(event) { active.where("events @> ?", [event].to_json) }

  AVAILABLE_EVENTS = %w[
    application.received application.stage_changed
    candidate.new job.posted job.expired
  ].freeze

  def trigger!(event, payload)
    return unless active?

    WebhookDeliveryJob.perform_later(id, event, payload.to_json)
    update!(last_triggered_at: Time.current)
  end

  def deactivate!
    update!(active: false)
  end

  def record_failure!
    increment!(:failure_count)
    deactivate! if failure_count >= 5
  end
end
