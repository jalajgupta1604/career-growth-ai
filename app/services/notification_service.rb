class NotificationService
  def self.notify(user:, title:, body: nil, category: "system", action_url: nil)
    user.notifications.create!(
      title: title,
      body: body,
      category: category,
      action_url: action_url
    )
  end

  def self.achievement(user:, title:, body: nil)
    notify(user: user, title: title, body: body, category: "achievement")
  end

  def self.subscription_event(user:, title:, body: nil)
    notify(user: user, title: title, body: body, category: "subscription", action_url: "/subscriptions/manage")
  end

  def self.interview_reminder(user:, interview:)
    notify(
      user: user,
      title: "Mock interview ready for review",
      body: "Your #{interview.interview_type} interview results are available.",
      category: "interview",
      action_url: "/mock_interviews/#{interview.id}"
    )
  end

  def self.community_activity(user:, title:, body: nil, url: nil)
    notify(user: user, title: title, body: body, category: "community", action_url: url)
  end
end
