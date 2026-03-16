class SearchQuery < ApplicationRecord
  belongs_to :user, optional: true

  validates :query, presence: true

  scope :recent, -> { order(created_at: :desc) }
  scope :popular, -> {
    where("created_at > ?", 30.days.ago)
      .group(:query)
      .order("count_id DESC")
      .limit(20)
      .count(:id)
  }

  def self.top_zero_result_queries(limit = 10)
    where(results_count: 0)
      .where("created_at > ?", 30.days.ago)
      .group(:query)
      .order("count_id DESC")
      .limit(limit)
      .count(:id)
  end
end
