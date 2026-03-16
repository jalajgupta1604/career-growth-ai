class DunningService
  ESCALATION_SCHEDULE = {
    0 => { state: "reminded", days: 0, action: :notify_payment_failed },
    1 => { state: "reminded", days: 3, action: :gentle_reminder },
    2 => { state: "urgent", days: 7, action: :urgent_notice },
    3 => { state: "paused", days: 14, action: :pause_subscription }
  }.freeze

  def self.process_all
    Subscription.where(status: [:halted, :pending]).find_each do |sub|
      new(sub).process
    end
  end

  def initialize(subscription)
    @subscription = subscription
  end

  def process
    schedule = ESCALATION_SCHEDULE[@subscription.dunning_attempts]
    return pause_subscription if schedule.nil?

    days_since = @subscription.last_dunning_at ? (Date.current - @subscription.last_dunning_at.to_date).to_i : 999

    return if days_since < schedule[:days] && @subscription.dunning_attempts > 0

    send(schedule[:action])
    @subscription.update!(
      dunning_state: schedule[:state],
      dunning_attempts: @subscription.dunning_attempts + 1,
      last_dunning_at: Time.current
    )
  end

  def reset!
    @subscription.update!(
      dunning_attempts: 0,
      last_dunning_at: nil,
      dunning_state: nil
    )
  end

  private

  def notify_payment_failed
    NotificationService.notify(
      user: @subscription.user,
      title: "Payment failed",
      body: "Your subscription payment could not be processed. Please update your payment method.",
      category: "subscription",
      action_url: "/subscriptions/manage"
    )
    UserMailer.payment_failed(@subscription.user, @subscription).deliver_later
  end

  def gentle_reminder
    NotificationService.notify(
      user: @subscription.user,
      title: "Payment reminder",
      body: "Your subscription payment is still pending. Please retry to avoid losing access.",
      category: "subscription",
      action_url: "/subscriptions/manage"
    )
  end

  def urgent_notice
    NotificationService.notify(
      user: @subscription.user,
      title: "Urgent: Subscription at risk",
      body: "Your Pro features will be paused in 7 days if payment is not completed.",
      category: "subscription",
      action_url: "/subscriptions/manage"
    )
  end

  def pause_subscription
    @subscription.update!(
      status: :halted,
      dunning_state: "paused"
    )
    NotificationService.notify(
      user: @subscription.user,
      title: "Subscription paused",
      body: "Your Pro subscription has been paused due to payment failure. Your data is preserved — resubscribe anytime.",
      category: "subscription",
      action_url: "/subscriptions/manage"
    )
  end
end
