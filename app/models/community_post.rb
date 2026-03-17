class CommunityPost < ApplicationRecord
  belongs_to :user
  has_many :post_likes, dependent: :destroy

  enum :post_type, { milestone: "milestone", job_switch: "job_switch", learning: "learning", question: "question" }

  validates :content, presence: true

  scope :recent, -> { order(created_at: :desc) }
  scope :feed, -> { where(moderation_status: "approved").recent.includes(:user) }
  scope :pending_review, -> { where(moderation_status: "pending_review") }
  scope :rejected, -> { where(moderation_status: "rejected") }

  after_create :run_auto_moderation

  def liked_by?(user)
    post_likes.exists?(user_id: user.id)
  end

  def display_author
    anonymous? ? "Anonymous Professional" : (user.full_name || "User")
  end

  private

  def run_auto_moderation
    AutoModerationService.moderate_post(self)
  end
end
