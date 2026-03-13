class BadgeService
  def self.check_and_award(user)
    check_interview_ace(user)
    check_code_master(user)
    check_streak_warrior(user)
    check_community_star(user)
    check_salary_expert(user)
  end

  private

  def self.award_badge(user, badge_type, skill_name: nil, level: "bronze", criteria: {})
    existing = user.skill_badges.find_by(badge_type: badge_type, skill_name: skill_name)
    return if existing && level_rank(existing.level) >= level_rank(level)

    if existing
      existing.update!(level: level, criteria_met: criteria)
    else
      user.skill_badges.create!(
        badge_type: badge_type,
        skill_name: skill_name,
        level: level,
        criteria_met: criteria,
        earned_at: Time.current
      )
    end

    NotificationService.achievement(
      user: user,
      title: "Badge Earned: #{SkillBadge::BADGE_TYPES.dig(badge_type, :name)}",
      body: "You earned the #{level} #{badge_type.humanize} badge!"
    )
  end

  def self.level_rank(level)
    %w[bronze silver gold platinum].index(level) || 0
  end

  def self.check_interview_ace(user)
    count = user.mock_interviews.where("score >= ?", 70).count
    return if count < 3
    level = if count >= 25 then "platinum"
           elsif count >= 15 then "gold"
           elsif count >= 8 then "silver"
           else "bronze"
           end
    award_badge(user, "interview_ace", level: level, criteria: { interviews_passed: count })
  end

  def self.check_code_master(user)
    count = user.code_submissions.where(status: :completed).where("score >= ?", 70).count
    return if count < 3
    level = if count >= 20 then "platinum"
           elsif count >= 12 then "gold"
           elsif count >= 6 then "silver"
           else "bronze"
           end
    award_badge(user, "code_master", level: level, criteria: { challenges_passed: count })
  end

  def self.check_streak_warrior(user)
    streak = user.user_streak&.current_streak || 0
    return if streak < 7
    level = if streak >= 90 then "platinum"
           elsif streak >= 30 then "gold"
           elsif streak >= 14 then "silver"
           else "bronze"
           end
    award_badge(user, "streak_warrior", level: level, criteria: { streak_days: streak })
  end

  def self.check_community_star(user)
    posts = user.community_posts.count + user.discussion_threads.count + user.discussion_replies.count
    return if posts < 10
    level = if posts >= 100 then "platinum"
           elsif posts >= 50 then "gold"
           elsif posts >= 25 then "silver"
           else "bronze"
           end
    award_badge(user, "community_star", level: level, criteria: { contributions: posts })
  end

  def self.check_salary_expert(user)
    count = user.salary_submissions.count
    return if count < 3
    level = if count >= 20 then "platinum"
           elsif count >= 10 then "gold"
           elsif count >= 5 then "silver"
           else "bronze"
           end
    award_badge(user, "salary_expert", level: level, criteria: { submissions: count })
  end
end
