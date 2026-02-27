class SalaryBenchmark < ApplicationRecord
  validates :role, :city, :experience_range, presence: true
  validates :min_salary, :median_salary, :max_salary, presence: true, numericality: { greater_than: 0 }

  scope :for_role, ->(role) { where(role: role) }
  scope :for_city, ->(city) { where(city: city) }
  scope :for_experience, ->(range) { where(experience_range: range) }

  def self.lookup(role:, city:, experience_range:, company_type: nil)
    scope = for_role(role).for_city(city).for_experience(experience_range)
    scope = scope.where(company_type: company_type) if company_type.present?
    scope.first
  end
end
