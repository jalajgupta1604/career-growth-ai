class CompanyAnalyticsSnapshot < ApplicationRecord
  belongs_to :company

  validates :period, presence: true
  validates :period, uniqueness: { scope: :company_id }

  scope :recent, -> { order(created_at: :desc) }
end
