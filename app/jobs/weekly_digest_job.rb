class WeeklyDigestJob < ApplicationJob
  queue_as :default

  def perform
    User.where.not(email: nil).find_each do |user|
      next unless NotificationService.email_enabled?(user, "weekly_digest")

      stats = build_stats(user)
      next if stats.values.all?(&:zero?)

      UserMailer.weekly_digest(user, stats).deliver_later
    end
  end

  private

  def build_stats(user)
    week_start = 1.week.ago

    {
      challenges_completed: user.challenge_attempts.where("created_at >= ?", week_start).count,
      current_streak: user.user_streak&.current_streak || 0,
      interviews_practiced: user.mock_interviews.where("created_at >= ?", week_start).count,
      badges_earned: user.skill_badges.where("created_at >= ?", week_start).count,
      new_lessons_available: 0
    }
  end
end
