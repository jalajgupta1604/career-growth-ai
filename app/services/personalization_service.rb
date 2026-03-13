class PersonalizationService
  DASHBOARD_SECTIONS = %w[
    quick_stats resume_upload reports pro_tools community_intelligence
    advanced_tools marketplace account
  ].freeze

  def self.personalized_layout(user)
    return default_layout if user.dashboard_layout.blank?

    user.dashboard_layout.symbolize_keys
  end

  def self.update_engagement_score(user)
    score = 0.0
    score += 10 if user.last_active_at && user.last_active_at > 1.day.ago
    score += 5 * [user.mock_interviews.where("created_at > ?", 30.days.ago).count, 10].min
    score += 3 * [user.challenge_attempts.where("created_at > ?", 30.days.ago).count, 10].min
    score += 2 * [user.community_posts.where("created_at > ?", 30.days.ago).count, 5].min
    score += 15 if user.subscribed?
    score += 5 if user.user_streak&.current_streak.to_i > 7

    user.update_column(:engagement_score, [score, 100].min)
  end

  def self.recommended_actions(user)
    actions = []

    unless user.resumes.any?
      actions << { title: "Upload your resume", description: "Get personalized career insights", url: "/resumes/new", priority: 1 }
    end

    if user.mock_interviews.empty?
      actions << { title: "Take a mock interview", description: "Practice with AI interviewer", url: "/mock_interviews/new", priority: 2 }
    end

    if user.salary_submissions.empty?
      actions << { title: "Submit your salary", description: "Help the community & get benchmarks", url: "/salary_submissions/new", priority: 3 }
    end

    if user.revision_items.due.any?
      actions << { title: "Review #{user.revision_items.due.count} items", description: "Spaced repetition items due today", url: "/revisions", priority: 1 }
    end

    unless user.subscribed?
      actions << { title: "Upgrade to Pro", description: "Unlock all premium features", url: "/pricing", priority: 4 }
    end

    actions.sort_by { |a| a[:priority] }.first(5)
  end

  def self.classify_user_type(user)
    if user.job_applications.any? || user.job_recommendations.any?
      "job_seeker"
    elsif user.negotiation_sessions.any? || user.offer_analyses.any?
      "salary_negotiator"
    else
      "skill_builder"
    end
  end

  private

  def self.default_layout
    { sections: DASHBOARD_SECTIONS }
  end
end
