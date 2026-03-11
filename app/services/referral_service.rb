class ReferralService
  REWARD_DAYS = 7

  def initialize(user)
    @user = user
  end

  def apply_referral_code(code)
    return { success: false, error: "Invalid referral code" } if code.blank?
    return { success: false, error: "You can't use your own referral code" } if @user.referral_code == code

    referrer = User.find_by(referral_code: code)
    return { success: false, error: "Referral code not found" } unless referrer
    return { success: false, error: "Referral already applied" } if @user.referred_by_id.present?

    @user.update!(referred_by_id: referrer.id)

    ReferralReward.create!(
      user: referrer,
      referred_user: @user,
      reward_type: "referral_signup",
      reward_days: REWARD_DAYS,
      status: "pending"
    )

    { success: true, message: "Referral code applied! #{referrer.full_name || 'Your friend'} will receive #{REWARD_DAYS} days of Pro access." }
  end

  def credit_pending_rewards
    pending = @user.referral_rewards.pending
    pending.each(&:credit!)
    pending.count
  end

  def dashboard_data
    referrals = User.where(referred_by_id: @user.id)
    rewards = @user.referral_rewards.recent

    {
      referral_code: @user.referral_code,
      total_referrals: referrals.count,
      successful_referrals: rewards.credited.count,
      pending_referrals: rewards.pending.count,
      total_reward_days: rewards.credited.sum(:reward_days),
      recent_referrals: referrals.order(created_at: :desc).limit(10).map { |u|
        {
          name: u.full_name || "User",
          joined_at: u.created_at,
          subscribed: u.subscribed?
        }
      },
      rewards: rewards.limit(10)
    }
  end
end
