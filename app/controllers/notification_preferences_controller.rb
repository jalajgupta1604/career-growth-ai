class NotificationPreferencesController < ApplicationController
  before_action :authenticate_user!

  def show
    @preferences = current_user.notification_preferences || {}
    @email_prefs = @preferences["email"] || {}
  end

  def update
    prefs = current_user.notification_preferences || {}
    prefs["email"] = {
      "weekly_digest" => params.dig(:email, :weekly_digest) == "1",
      "streak_reminders" => params.dig(:email, :streak_reminders) == "1",
      "subscription_updates" => params.dig(:email, :subscription_updates) == "1",
      "interview_notifications" => params.dig(:email, :interview_notifications) == "1",
      "community_activity" => params.dig(:email, :community_activity) == "1"
    }

    current_user.update!(notification_preferences: prefs)
    redirect_to notification_preferences_path, notice: "Notification preferences updated."
  end
end
