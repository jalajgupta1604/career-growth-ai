class SkillBadge < ApplicationRecord
  belongs_to :user

  validates :badge_type, presence: true
  validates :badge_type, uniqueness: { scope: [:user_id, :skill_name] }
  validates :level, inclusion: { in: %w[bronze silver gold platinum] }

  BADGE_TYPES = {
    "interview_ace" => { name: "Interview Ace", icon: "military_tech", description: "High mock interview scores" },
    "code_master" => { name: "Code Master", icon: "code", description: "Coding playground achievements" },
    "peer_champion" => { name: "Peer Champion", icon: "groups", description: "Active in peer practice" },
    "streak_warrior" => { name: "Streak Warrior", icon: "local_fire_department", description: "Consistent daily challenges" },
    "community_star" => { name: "Community Star", icon: "star", description: "Top community contributor" },
    "salary_expert" => { name: "Salary Expert", icon: "payments", description: "Salary data contributor" }
  }.freeze

  scope :recent, -> { order(earned_at: :desc) }

  def display_name
    BADGE_TYPES.dig(badge_type, :name) || badge_type.humanize
  end

  def icon
    BADGE_TYPES.dig(badge_type, :icon) || "emoji_events"
  end

  def level_color
    { "bronze" => "text-amber-700 bg-amber-100", "silver" => "text-gray-600 bg-gray-200",
      "gold" => "text-yellow-700 bg-yellow-100", "platinum" => "text-cyan-700 bg-cyan-100" }[level]
  end
end
