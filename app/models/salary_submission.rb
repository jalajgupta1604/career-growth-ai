class SalarySubmission < ApplicationRecord
  belongs_to :user

  validates :role, :city, :experience_years, :base_salary, presence: true
  validates :base_salary, numericality: { greater_than: 0 }
  validates :experience_years, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 40 }

  scope :verified, -> { where(verified: true) }
  scope :recent, -> { order(created_at: :desc) }
  scope :for_role, ->(role) { where(role: role) }
  scope :for_city, ->(city) { where(city: city) }
  scope :for_experience, ->(range) { where(experience_years: range) }

  def self.experience_range_for(years)
    case years
    when 0..2 then 0..2
    when 3..5 then 3..5
    when 6..8 then 6..8
    when 9..12 then 9..12
    else 12..40
    end
  end

  def display_name
    anonymous? ? "Anonymous" : user.full_name
  end
end
