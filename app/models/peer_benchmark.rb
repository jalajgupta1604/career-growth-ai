class PeerBenchmark < ApplicationRecord
  belongs_to :user

  scope :recent, -> { order(created_at: :desc) }

  def overall_percentile
    return 0 unless salary_percentile && skill_percentile && interview_percentile
    ((salary_percentile + skill_percentile + interview_percentile) / 3.0).round(1)
  end
end
