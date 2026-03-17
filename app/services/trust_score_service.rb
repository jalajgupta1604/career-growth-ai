class TrustScoreService
  TRUST_LEVELS = {
    "new" => 0..24,
    "basic" => 25..49,
    "trusted" => 50..74,
    "veteran" => 75..89,
    "exemplary" => 90..100
  }.freeze

  def initialize(user)
    @user = user
  end

  def calculate
    score = 50.0 # Base score

    # Account age bonus (up to +15)
    days_old = (Time.current - @user.created_at).to_f / 1.day
    score += [days_old / 30.0 * 3, 15].min

    # Community contributions (+20 max)
    posts_count = @user.community_posts.where(moderation_status: "approved").count
    score += [posts_count * 2, 10].min

    discussion_count = @user.discussion_threads.count + @user.discussion_replies.count
    score += [discussion_count, 10].min

    # Helpful interactions (+10 max)
    score += [@user.helpful_count * 2, 10].min

    # Flags received penalty (-5 per flag, max -30)
    score -= [@user.flags_received_count * 5, 30].min

    # Content rejected penalty (-10 per rejection)
    rejected_posts = @user.community_posts.where(moderation_status: "rejected").count
    score -= [rejected_posts * 10, 20].min

    # Profile completeness bonus (+5)
    score += 5 if @user.onboarding_complete?

    # Subscription bonus (+5)
    score += 5 if @user.subscribed?

    # Clamp and determine level
    final_score = score.clamp(0, 100).round(1)
    level = determine_level(final_score)

    @user.update!(trust_score: final_score, trust_level: level)

    { score: final_score, level: level }
  end

  def self.recalculate_all
    User.find_each do |user|
      new(user).calculate
    rescue => e
      Rails.logger.error("TrustScore error for user #{user.id}: #{e.message}")
    end
  end

  private

  def determine_level(score)
    TRUST_LEVELS.each do |level, range|
      return level if range.include?(score.to_i)
    end
    "new"
  end
end
