class DiscussionThread < ApplicationRecord
  belongs_to :user
  has_many :discussion_replies, dependent: :destroy

  validates :title, :body, :category, presence: true
  validates :category, inclusion: { in: %w[backend frontend devops data_science career general] }

  scope :recent, -> { order(pinned: :desc, created_at: :desc) }
  scope :by_category, ->(cat) { where(category: cat) }
end
