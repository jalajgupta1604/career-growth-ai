class Subscription < ApplicationRecord
  belongs_to :user

  enum :status, {
    created: 0,
    authenticated: 1,
    active: 2,
    halted: 3,
    cancelled: 4,
    completed: 5,
    expired: 6,
    pending: 7
  }

  PLANS = {
    "monthly" => {
      amount: 499,
      amount_in_paise: 499_00,
      period: "monthly",
      interval: 1,
      description: "Pro Monthly — ₹499/month",
      env_key: "RAZORPAY_MONTHLY_PLAN_ID"
    },
    "yearly" => {
      amount: 4999,
      amount_in_paise: 4999_00,
      period: "yearly",
      interval: 1,
      description: "Pro Yearly — ₹4,999/year (Save 2 months)",
      env_key: "RAZORPAY_YEARLY_PLAN_ID"
    }
  }.freeze

  validates :razorpay_subscription_id, presence: true, uniqueness: true
  validates :user_id, uniqueness: true
  validates :plan_name, presence: true, inclusion: { in: PLANS.keys }

  def active_access?
    active? || authenticated? || (cancelled? && current_period_end.present? && current_period_end > Time.current)
  end

  def plan_details
    PLANS[plan_name]
  end

  def self.razorpay_plan_id(plan_name)
    plan = PLANS[plan_name]
    return nil unless plan

    ENV.fetch(plan[:env_key], "")
  end
end
