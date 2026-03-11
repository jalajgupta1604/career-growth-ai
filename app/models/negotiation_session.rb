class NegotiationSession < ApplicationRecord
  belongs_to :user

  validates :user, presence: true
  validates :current_offer, presence: true, numericality: { greater_than: 0 }

  scope :recent, -> { order(created_at: :desc) }

  def salary_gap
    return 0 unless expected_salary && current_offer && current_offer > 0
    ((expected_salary - current_offer) / current_offer * 100).round(1)
  end
end
