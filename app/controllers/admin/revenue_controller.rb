module Admin
  class RevenueController < BaseController
    def index
      @total_revenue = Payment.where(status: :captured).sum(:amount) / 100.0
      @total_refunded = Payment.where(status: :refunded).sum(:amount) / 100.0
      @active_subscriptions = Subscription.where(status: :active).count
      @monthly_subscriptions = Subscription.where(status: :active, plan_name: "monthly").count
      @yearly_subscriptions = Subscription.where(status: :active, plan_name: "yearly").count
      @dunning_count = Subscription.where(status: [:halted, :pending]).count
      @recent_payments = Payment.includes(:user).order(created_at: :desc).limit(20)
      @mrr = calculate_mrr
    end

    private

    def calculate_mrr
      monthly = Subscription.where(status: :active, plan_name: "monthly").sum(:amount)
      yearly = Subscription.where(status: :active, plan_name: "yearly").sum(:amount) / 12
      (monthly + yearly) / 100.0
    end
  end
end
