class InterviewExperience < ApplicationRecord
  belongs_to :user

  validates :company_name, :role, presence: true
  validates :difficulty, inclusion: { in: %w[easy medium hard] }
  validates :outcome, inclusion: { in: %w[selected rejected in_progress no_response] }, allow_nil: true
  validates :overall_rating, numericality: { in: 1..5 }, allow_nil: true

  scope :recent, -> { order(created_at: :desc) }
  scope :for_company, ->(name) { where("LOWER(company_name) = ?", name.downcase) }
  scope :for_role, ->(role) { where(role: role) }

  def display_name
    anonymous? ? "Anonymous" : user.full_name
  end

  def outcome_color
    case outcome
    when "selected" then "green"
    when "rejected" then "red"
    when "in_progress" then "yellow"
    else "gray"
    end
  end

  def difficulty_color
    case difficulty
    when "easy" then "green"
    when "medium" then "yellow"
    when "hard" then "red"
    else "gray"
    end
  end
end
