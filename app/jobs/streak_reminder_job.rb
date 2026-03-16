class StreakReminderJob < ApplicationJob
  queue_as :default

  def perform
    UserStreak.where("current_streak > 0")
              .where("last_activity_date = ?", Date.yesterday)
              .includes(:user)
              .find_each do |streak|
      user = streak.user
      next unless NotificationService.email_enabled?(user, "streak_reminders")

      UserMailer.streak_reminder(user).deliver_later

      NotificationService.notify(
        user: user,
        title: "Your #{streak.current_streak}-day streak is at risk!",
        body: "Complete today's challenge to keep your streak alive.",
        category: "achievement",
        action_url: "/daily_challenge"
      )
    end
  end
end
