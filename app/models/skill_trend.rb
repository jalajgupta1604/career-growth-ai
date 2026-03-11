class SkillTrend < ApplicationRecord
  validates :skill_name, :period, presence: true
  validates :skill_name, uniqueness: { scope: [:role, :period] }

  scope :trending_up, -> { where(trend_direction: "rising") }
  scope :trending_down, -> { where(trend_direction: "declining") }
  scope :for_role, ->(role) { where(role: role) }
  scope :for_period, ->(period) { where(period: period) }
  scope :top_demand, -> { order(demand_score: :desc) }

  def rising?
    trend_direction == "rising"
  end

  def declining?
    trend_direction == "declining"
  end

  def trend_badge_color
    case trend_direction
    when "rising" then "green"
    when "declining" then "red"
    else "gray"
    end
  end
end
