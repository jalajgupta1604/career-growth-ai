class CandidateSearch < ApplicationRecord
  belongs_to :employer_profile

  def execute
    scope = User.where.not(role: nil)
    filters = self.filters.symbolize_keys

    scope = scope.where(role: filters[:role]) if filters[:role].present?
    scope = scope.where(city: filters[:city]) if filters[:city].present?

    if filters[:experience_min].present?
      scope = scope.where("experience_years >= ?", filters[:experience_min])
    end
    if filters[:experience_max].present?
      scope = scope.where("experience_years <= ?", filters[:experience_max])
    end

    scope.select(:id, :full_name, :role, :city, :experience_years).limit(50)
  end
end
