class ReEngagementJob < ApplicationJob
  queue_as :default

  TIERS = [
    { days_inactive: 7, subject: "We miss you! Here's what's new", template: :day_7 },
    { days_inactive: 14, subject: "Your career growth is waiting", template: :day_14 },
    { days_inactive: 30, subject: "Come back and pick up where you left off", template: :day_30 }
  ].freeze

  def perform
    TIERS.each do |tier|
      inactive_users(tier[:days_inactive]).find_each do |user|
        next unless NotificationService.email_enabled?(user, "re_engagement")
        next if already_sent?(user, tier[:template])

        UserMailer.re_engagement(user, tier[:template], tier[:subject]).deliver_later
        track_sent(user, tier[:template])
      end
    end
  end

  private

  def inactive_users(days)
    cutoff = days.days.ago
    User.where("last_sign_in_at < ? OR (last_sign_in_at IS NULL AND created_at < ?)", cutoff, cutoff)
        .where("last_sign_in_at > ? OR created_at > ?", (days + 7).days.ago, (days + 7).days.ago)
  end

  def already_sent?(user, template)
    prefs = user.notification_preferences || {}
    sent = prefs["re_engagement_sent"] || {}
    sent[template.to_s].present? && Time.parse(sent[template.to_s]) > 30.days.ago
  rescue
    false
  end

  def track_sent(user, template)
    prefs = user.notification_preferences || {}
    prefs["re_engagement_sent"] ||= {}
    prefs["re_engagement_sent"][template.to_s] = Time.current.iso8601
    user.update_column(:notification_preferences, prefs)
  end
end
