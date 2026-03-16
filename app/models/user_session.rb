class UserSession < ApplicationRecord
  belongs_to :user

  validates :session_token, presence: true, uniqueness: true

  scope :active, -> { where("last_active_at > ?", 30.days.ago) }
  scope :recent, -> { order(last_active_at: :desc) }

  def device_label
    case device_type
    when "mobile" then "Mobile"
    when "tablet" then "Tablet"
    else "Desktop"
    end
  end

  def current?(token)
    session_token == token
  end
end
