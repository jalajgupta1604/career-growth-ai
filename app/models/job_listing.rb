class JobListing < ApplicationRecord
  has_many :job_recommendations, dependent: :destroy

  validates :title, :company_name, presence: true

  scope :active_listings, -> { where(active: true) }
  scope :for_location, ->(loc) { where("LOWER(location) LIKE ?", "%#{loc.downcase}%") }
  scope :recent, -> { order(posted_at: :desc) }

  def salary_range_text
    return nil unless min_salary || max_salary
    parts = []
    parts << "₹#{(min_salary / 100000).round(1)}L" if min_salary
    parts << "₹#{(max_salary / 100000).round(1)}L" if max_salary
    parts.join(" - ")
  end

  def skills_list
    ((required_skills || []) + (preferred_skills || [])).uniq
  end
end
