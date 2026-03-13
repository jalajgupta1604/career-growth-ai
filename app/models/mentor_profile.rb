class MentorProfile < ApplicationRecord
  belongs_to :user

  scope :available, -> { where(available: true) }
  scope :recent, -> { order(created_at: :desc) }

  def mentee_count
    0 # Placeholder for future mentorship tracking
  end

  def has_capacity?
    mentee_count < max_mentees
  end
end
