class UserStreak < ApplicationRecord
  belongs_to :user

  def record_completion!
    today = Date.current

    return if last_completed_date == today

    if last_completed_date == today - 1
      self.current_streak += 1
    else
      self.current_streak = 1
    end

    self.longest_streak = [longest_streak, current_streak].max
    self.last_completed_date = today
    save!
  end

  def active_today?
    last_completed_date == Date.current
  end

  def streak_alive?
    last_completed_date.present? && last_completed_date >= Date.current - 1
  end
end
