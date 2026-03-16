class UserHealthService
  WEIGHTS = {
    activity: 0.30,
    engagement: 0.25,
    subscription: 0.20,
    completeness: 0.15,
    recency: 0.10
  }.freeze

  def initialize(user)
    @user = user
  end

  def score
    (
      activity_score * WEIGHTS[:activity] +
      engagement_score * WEIGHTS[:engagement] +
      subscription_score * WEIGHTS[:subscription] +
      completeness_score * WEIGHTS[:completeness] +
      recency_score * WEIGHTS[:recency]
    ).round(1)
  end

  def churn_risk
    s = score
    if s >= 70 then "low"
    elsif s >= 40 then "medium"
    else "high"
    end
  end

  def details
    {
      score: score,
      churn_risk: churn_risk,
      activity: activity_score.round(1),
      engagement: engagement_score.round(1),
      subscription: subscription_score.round(1),
      completeness: completeness_score.round(1),
      recency: recency_score.round(1)
    }
  end

  private

  def activity_score
    events = AnalyticsEvent.where(user_id: @user.id).where("created_at > ?", 30.days.ago).count
    [events.to_f / 50 * 100, 100].min
  end

  def engagement_score
    factors = 0
    factors += 25 if @user.challenge_attempts.where("created_at > ?", 7.days.ago).exists?
    factors += 25 if @user.mock_interviews.where("created_at > ?", 30.days.ago).exists?
    factors += 25 if @user.community_posts.where("created_at > ?", 30.days.ago).exists? ||
                      @user.discussion_replies.where("created_at > ?", 30.days.ago).exists?
    factors += 25 if @user.user_streak&.current_streak.to_i > 0
    factors.to_f
  end

  def subscription_score
    return 100 if @user.active_subscription?
    return 60 if @user.legacy_paid?
    0
  end

  def completeness_score
    fields = [:full_name, :role, :city, :experience_years, :current_salary]
    filled = fields.count { |f| @user.send(f).present? }
    has_resume = @user.resumes.exists? ? 1 : 0
    ((filled + has_resume).to_f / (fields.length + 1) * 100)
  end

  def recency_score
    last_seen = @user.last_sign_in_at || @user.created_at
    days_ago = (Date.current - last_seen.to_date).to_i
    if days_ago <= 1 then 100
    elsif days_ago <= 7 then 80
    elsif days_ago <= 14 then 50
    elsif days_ago <= 30 then 20
    else 0
    end
  end
end
