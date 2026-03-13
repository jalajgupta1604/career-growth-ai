class CommunityPost < ApplicationRecord
  belongs_to :user
  has_many :post_likes, dependent: :destroy

  enum :post_type, { milestone: "milestone", job_switch: "job_switch", learning: "learning", question: "question" }

  validates :content, presence: true

  scope :recent, -> { order(created_at: :desc) }
  scope :feed, -> { recent.includes(:user) }

  def liked_by?(user)
    post_likes.exists?(user_id: user.id)
  end

  def display_author
    anonymous? ? "Anonymous Professional" : (user.full_name || "User")
  end
end
