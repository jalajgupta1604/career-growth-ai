class JobRecommendation < ApplicationRecord
  belongs_to :user
  belongs_to :job_listing

  validates :user_id, uniqueness: { scope: :job_listing_id }

  scope :by_score, -> { order(match_score: :desc) }
  scope :unseen, -> { where(status: "new") }
  scope :saved, -> { where(status: "saved") }
  scope :applied, -> { where(status: "applied") }
  scope :recent, -> { order(created_at: :desc) }

  def mark_viewed!
    update!(viewed_at: Time.current, status: "viewed") if status == "new"
  end

  def save_job!
    update!(saved_at: Time.current, status: "saved")
  end

  def mark_applied!
    update!(applied_at: Time.current, status: "applied")
  end

  def match_percentage
    (match_score.to_f * 100).round
  end
end
