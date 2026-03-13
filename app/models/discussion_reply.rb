class DiscussionReply < ApplicationRecord
  belongs_to :discussion_thread, counter_cache: :replies_count
  belongs_to :user

  validates :body, presence: true

  scope :recent, -> { order(created_at: :asc) }
end
