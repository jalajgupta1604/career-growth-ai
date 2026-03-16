class SmartNudgeService
  def initialize(user)
    @user = user
  end

  def generate_nudges
    nudges = []
    nudges << job_match_nudge
    nudges << readiness_nudge
    nudges << streak_nudge
    nudges << community_nudge
    nudges << new_pack_nudge
    nudges.compact.first(3)
  end

  private

  def job_match_nudge
    return unless @user.role.present?

    new_jobs = JobPosting.active_listings
                         .where("created_at > ?", 7.days.ago)
                         .where("title ILIKE ? OR description ILIKE ?", "%#{@user.role}%", "%#{@user.role}%")
                         .count
    return if new_jobs.zero?

    {
      icon: "work",
      title: "#{new_jobs} new #{new_jobs == 1 ? 'job matches' : 'jobs match'} your profile",
      action_url: "/job_recommendations",
      category: "career"
    }
  end

  def readiness_nudge
    score = @user.readiness_scores.order(created_at: :desc).first
    prev = @user.readiness_scores.order(created_at: :desc).offset(1).first
    return unless score && prev

    improvement = score.overall_score - prev.overall_score
    return unless improvement > 5

    {
      icon: "trending_up",
      title: "Your readiness score improved #{improvement.round}% this week",
      action_url: "/dashboard",
      category: "achievement"
    }
  end

  def streak_nudge
    streak = @user.user_streak
    return unless streak && streak.current_streak >= 7 && streak.current_streak % 7 == 0

    {
      icon: "local_fire_department",
      title: "#{streak.current_streak}-day streak! Keep the momentum going",
      action_url: "/daily_challenge",
      category: "achievement"
    }
  end

  def community_nudge
    replies = DiscussionReply.joins(:discussion_thread)
                             .where(discussion_threads: { user_id: @user.id })
                             .where("discussion_replies.created_at > ?", 7.days.ago)
                             .where.not(user_id: @user.id)
                             .count
    return if replies.zero?

    {
      icon: "forum",
      title: "#{replies} new #{replies == 1 ? 'reply' : 'replies'} on your discussions",
      action_url: "/discussions",
      category: "community"
    }
  end

  def new_pack_nudge
    new_packs = CmsContent.where(content_type: "company_pack", status: "published")
                          .where("published_at > ?", 14.days.ago)
                          .count
    return if new_packs.zero?

    {
      icon: "business_center",
      title: "#{new_packs} new company interview #{new_packs == 1 ? 'pack' : 'packs'} available",
      action_url: "/company-packs",
      category: "interview"
    }
  end
end
