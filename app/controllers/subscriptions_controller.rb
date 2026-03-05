class SubscriptionsController < ApplicationController
  before_action :authenticate_user!, except: [:webhook]
  skip_before_action :verify_authenticity_token, only: [:webhook]

  def new
    @plan = params[:plan] || "monthly"
    redirect_to subscriptions_manage_path if current_user.active_subscription?
  end

  def create
    plan_name = params[:plan] || "monthly"
    plan = Subscription::PLANS[plan_name]

    unless plan
      render json: { error: "Invalid plan" }, status: :unprocessable_entity
      return
    end

    razorpay_plan_id = Subscription.razorpay_plan_id(plan_name)

    subscription_data = {
      plan_id: razorpay_plan_id,
      total_count: plan_name == "monthly" ? 120 : 10,
      customer_notify: 1
    }

    if current_user.email.present?
      subscription_data[:notes] = { user_id: current_user.id, email: current_user.email }
    end

    razorpay_sub = Razorpay::Subscription.create(subscription_data)

    sub = current_user.subscription || current_user.build_subscription
    sub.update!(
      razorpay_subscription_id: razorpay_sub.id,
      razorpay_plan_id: razorpay_plan_id,
      plan_name: plan_name,
      status: :created,
      amount: plan[:amount],
      short_url: razorpay_sub.short_url,
      total_count: subscription_data[:total_count]
    )

    render json: {
      subscription_id: razorpay_sub.id,
      key: ENV.fetch("RAZORPAY_KEY_ID", ""),
      plan_name: plan_name,
      amount: plan[:amount_in_paise],
      currency: "INR"
    }
  rescue => e
    Rails.logger.error("Subscription creation failed: #{e.message}")
    render json: { error: "Subscription creation failed" }, status: :unprocessable_entity
  end

  def verify
    subscription = current_user.subscription

    unless subscription
      render json: { success: false, error: "Subscription not found" }, status: :not_found
      return
    end

    begin
      Razorpay::Utility.verify_subscription_payment_signature(
        razorpay_subscription_id: params[:razorpay_subscription_id],
        razorpay_payment_id: params[:razorpay_payment_id],
        razorpay_signature: params[:razorpay_signature]
      )

      subscription.update!(
        status: :active,
        current_period_start: Time.current,
        current_period_end: subscription.plan_name == "monthly" ? 1.month.from_now : 1.year.from_now,
        paid_count: subscription.paid_count + 1
      )

      render json: { success: true, message: "Subscription activated successfully" }
    rescue Razorpay::Error, SecurityError => e
      Rails.logger.error("Subscription verification failed: #{e.message}")
      render json: { success: false, error: "Subscription verification failed" }, status: :unprocessable_entity
    end
  end

  def manage
    @subscription = current_user.subscription
    @legacy_paid = current_user.legacy_paid?
  end

  def cancel
    subscription = current_user.subscription

    unless subscription&.active?
      redirect_to subscriptions_manage_path, alert: "No active subscription to cancel."
      return
    end

    begin
      Razorpay::Subscription.cancel(subscription.razorpay_subscription_id, cancel_at_cycle_end: true)

      subscription.update!(
        status: :cancelled,
        cancelled_at: Time.current
      )

      redirect_to subscriptions_manage_path, notice: "Subscription cancelled. You'll retain access until #{subscription.current_period_end&.strftime('%B %d, %Y')}."
    rescue => e
      Rails.logger.error("Subscription cancellation failed: #{e.message}")
      redirect_to subscriptions_manage_path, alert: "Failed to cancel subscription. Please try again."
    end
  end

  def webhook
    payload = request.body.read
    signature = request.headers["X-Razorpay-Signature"]

    begin
      Razorpay::Utility.verify_webhook_signature(payload, signature, ENV.fetch("RAZORPAY_WEBHOOK_SECRET", ""))
    rescue Razorpay::Error, SecurityError, StandardError
      head :bad_request
      return
    end

    event = JSON.parse(payload)
    handle_subscription_event(event)
    head :ok
  end

  private

  def handle_subscription_event(event)
    entity = event.dig("payload", "subscription", "entity")
    return unless entity

    subscription = Subscription.find_by(razorpay_subscription_id: entity["id"])
    return unless subscription

    case event["event"]
    when "subscription.activated"
      subscription.update!(
        status: :active,
        current_period_start: entity["current_start"] ? Time.at(entity["current_start"]) : Time.current,
        current_period_end: entity["current_end"] ? Time.at(entity["current_end"]) : nil,
        paid_count: entity["paid_count"] || subscription.paid_count,
        razorpay_customer_id: entity["customer_id"]
      )
    when "subscription.charged"
      subscription.update!(
        status: :active,
        current_period_start: entity["current_start"] ? Time.at(entity["current_start"]) : Time.current,
        current_period_end: entity["current_end"] ? Time.at(entity["current_end"]) : nil,
        paid_count: entity["paid_count"] || subscription.paid_count + 1
      )
    when "subscription.halted"
      subscription.update!(status: :halted)
    when "subscription.cancelled"
      subscription.update!(
        status: :cancelled,
        cancelled_at: subscription.cancelled_at || Time.current
      )
    when "subscription.completed"
      subscription.update!(status: :completed)
    when "subscription.pending"
      subscription.update!(status: :pending)
    end
  end
end
