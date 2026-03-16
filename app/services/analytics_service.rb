class AnalyticsService
  def self.dashboard_stats(period: 30.days.ago..Time.current)
    {
      total_users: User.count,
      new_users: User.where(created_at: period).count,
      active_users: AnalyticsEvent.in_period(period.first, period.last).select(:user_id).distinct.count,
      subscribers: Subscription.where(status: :active).count,
      mrr: calculate_mrr,
      churn_rate: calculate_churn_rate(period),
      top_features: top_features(period),
      conversion_funnel: conversion_funnel(period),
      cohorts: AnalyticsEvent.cohort_retention(months_back: 6),
      dau_mau_ratio: dau_mau_ratio
    }
  end

  def self.conversion_funnel(period = 30.days.ago..Time.current)
    AnalyticsEvent.funnel(
      %w[signup onboarding_complete report_generated subscription_started],
      period: period
    )
  end

  def self.top_features(period = 30.days.ago..Time.current)
    AnalyticsEvent.in_period(period.first, period.last)
                  .by_type("feature_used")
                  .group("properties->>'feature'")
                  .count
                  .sort_by { |_, v| -v }
                  .first(10)
                  .to_h
  end

  def self.revenue_forecast(months_ahead: 6)
    current_mrr = calculate_mrr
    growth_rate = calculate_growth_rate
    (1..months_ahead).map do |m|
      { month: m.months.from_now.strftime("%b %Y"), projected_mrr: (current_mrr * (1 + growth_rate) ** m).round(0) }
    end
  end

  private

  def self.calculate_mrr
    monthly = Subscription.where(status: :active, plan_name: "monthly").sum(:amount)
    yearly = Subscription.where(status: :active, plan_name: "yearly").sum(:amount) / 12
    (monthly + yearly) / 100.0
  end

  def self.calculate_churn_rate(period)
    start_count = Subscription.where("created_at < ?", period.first).where(status: :active).count
    return 0.0 if start_count == 0
    churned = Subscription.where(cancelled_at: period).count
    (churned.to_f / start_count * 100).round(1)
  end

  def self.calculate_growth_rate
    current = User.where("created_at >= ?", 30.days.ago).count
    previous = User.where(created_at: 60.days.ago..30.days.ago).count
    return 0.05 if previous == 0
    ((current - previous).to_f / previous).clamp(-0.5, 0.5)
  end

  def self.dau_mau_ratio
    dau = AnalyticsEvent.in_period(1.day.ago, Time.current).select(:user_id).distinct.count
    mau = AnalyticsEvent.in_period(30.days.ago, Time.current).select(:user_id).distinct.count
    return 0.0 if mau == 0
    (dau.to_f / mau * 100).round(1)
  end
end
