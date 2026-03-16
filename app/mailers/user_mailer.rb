class UserMailer < ApplicationMailer
  def welcome(user)
    @user = user
    mail(to: @user.email, subject: "Welcome to CareerGrowth AI!")
  end

  def streak_reminder(user)
    @user = user
    @streak = user.user_streak
    stop_delivery_if_unsubscribed(user, "streak_reminders")
    mail(to: @user.email, subject: "Don't lose your streak! Practice today")
  end

  def weekly_digest(user, stats)
    @user = user
    @stats = stats
    stop_delivery_if_unsubscribed(user, "weekly_digest")
    mail(to: @user.email, subject: "Your weekly career progress report")
  end

  def payment_receipt(user, subscription)
    @user = user
    @subscription = subscription
    mail(to: @user.email, subject: "Payment receipt — CareerGrowth AI Pro")
  end

  def subscription_cancelled(user, subscription)
    @user = user
    @subscription = subscription
    stop_delivery_if_unsubscribed(user, "subscription_updates")
    mail(to: @user.email, subject: "Your subscription has been cancelled")
  end

  def payment_failed(user, subscription)
    @user = user
    @subscription = subscription
    stop_delivery_if_unsubscribed(user, "subscription_updates")
    mail(to: @user.email, subject: "Action needed: Payment failed")
  end

  def re_engagement(user, template, subject)
    @user = user
    @template = template
    stop_delivery_if_unsubscribed(user, "re_engagement")
    mail(to: @user.email, subject: subject)
  end
end
