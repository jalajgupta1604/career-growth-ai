class CoachMessage < ApplicationRecord
  belongs_to :coach_conversation, counter_cache: :messages_count

  validates :role, presence: true, inclusion: { in: %w[user assistant system] }
  validates :content, presence: true

  scope :ordered, -> { order(created_at: :asc) }
  scope :recent, -> { order(created_at: :desc) }

  def user_message?
    role == "user"
  end

  def assistant_message?
    role == "assistant"
  end
end
