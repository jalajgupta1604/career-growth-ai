class SalaryForecast < ApplicationRecord
  belongs_to :user

  enum :status, { pending: 0, processing: 1, completed: 2, failed: 3 }

  scope :recent, -> { order(created_at: :desc) }

  def result_data
    {
      "projected_salaries" => projected_salaries,
      "skill_plan" => skill_plan,
      "market_factors" => market_factors,
      "summary" => market_factors.is_a?(Array) ? market_factors.map { |f| f["description"] }.compact.join(". ") : nil
    }
  end
end
