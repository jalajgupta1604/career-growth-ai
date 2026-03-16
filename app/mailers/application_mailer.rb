class ApplicationMailer < ActionMailer::Base
  default from: ENV.fetch("MAILER_FROM_ADDRESS", "noreply@careergrowth.ai")
  layout "mailer"

  private

  def stop_delivery_if_unsubscribed(user, category)
    prefs = user.notification_preferences || {}
    email_prefs = prefs["email"] || {}
    mail.perform_deliveries = false if email_prefs[category] == false
  end
end
