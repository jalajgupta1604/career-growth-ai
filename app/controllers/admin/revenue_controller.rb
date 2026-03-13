module Admin
  class RevenueController < BaseController
    def index
      @total_revenue = Payment.where(status: "paid").sum(:amount) / 100.0
      @active_subscriptions = Subscription.where(status: :active).count
      @monthly_subscriptions = Subscription.where(status: :active, plan_type: "monthly").count
      @yearly_subscriptions = Subscription.where(status: :active, plan_type: "yearly").count
      @recent_payments = Payment.where(status: "paid").order(created_at: :desc).limit(20)
      @mrr = calculate_mrr
    end

    private

    def calculate_mrr
      monthly = Subscription.where(status: :active, plan_type: "monthly").sum(:amount)
      yearly = Subscription.where(status: :active, plan_type: "yearly").sum(:amount) / 12
      (monthly + yearly) / 100.0
    end
  end
end
