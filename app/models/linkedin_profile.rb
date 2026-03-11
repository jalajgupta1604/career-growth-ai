class LinkedinProfile < ApplicationRecord
  belongs_to :user

  validates :user_id, uniqueness: true

  scope :synced, -> { where(sync_status: "synced") }

  def synced?
    sync_status == "synced"
  end

  def skills_list
    (skills_data || []).map { |s| s.is_a?(Hash) ? s["name"] : s.to_s }
  end

  def current_position
    (positions_data || []).first
  end

  def experience_years_from_linkedin
    positions = positions_data || []
    return 0 if positions.empty?
    earliest = positions.last
    start_year = earliest.dig("start_year").to_i
    return 0 if start_year.zero?
    Date.current.year - start_year
  end
end
