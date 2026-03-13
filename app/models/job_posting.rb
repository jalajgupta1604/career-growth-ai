class JobPosting < ApplicationRecord
  belongs_to :posted_by, class_name: "User"
  has_many :job_applications, dependent: :destroy

  enum :status, { draft: 0, active: 1, closed: 2 }

  validates :company_name, :title, presence: true

  scope :active_listings, -> { where(status: :active).order(created_at: :desc) }

  def salary_display
    return "Not disclosed" unless min_salary.present?
    max_salary.present? ? "₹#{min_salary / 100000}L - ₹#{max_salary / 100000}L" : "₹#{min_salary / 100000}L+"
  end

  def application_count
    job_applications.count
  end
end
