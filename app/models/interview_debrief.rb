class InterviewDebrief < ApplicationRecord
  belongs_to :user

  enum :status, { pending: 0, analyzing: 1, completed: 2, failed: 3 }

  validates :company_name, presence: true

  scope :recent, -> { order(created_at: :desc) }

  def analyzed?
    completed? && ai_analysis.present?
  end
end
