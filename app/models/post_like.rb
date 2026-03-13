class PostLike < ApplicationRecord
  belongs_to :user
  belongs_to :community_post, counter_cache: :likes_count

  validates :user_id, uniqueness: { scope: :community_post_id }
end
