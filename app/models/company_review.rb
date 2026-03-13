class CompanyReview < ApplicationRecord
  belongs_to :user

  validates :company_name, presence: true
  validates :overall_rating, presence: true, inclusion: { in: 1..5 }
  validates :interview_difficulty, inclusion: { in: %w[easy medium hard very_hard] }, allow_blank: true
  validates :employment_status, inclusion: { in: %w[current former] }

  scope :recent, -> { order(created_at: :desc) }
  scope :for_company, ->(name) { where("LOWER(company_name) = ?", name.downcase) }

  def self.average_rating_for(company_name)
    for_company(company_name).average(:overall_rating)&.round(1) || 0
  end
end
