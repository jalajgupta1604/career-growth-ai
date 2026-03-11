class CoachConversation < ApplicationRecord
  belongs_to :user
  has_many :coach_messages, dependent: :destroy

  scope :active_conversations, -> { where(status: "active") }
  scope :recent, -> { order(updated_at: :desc) }

  def active?
    status == "active"
  end

  def archive!
    update!(status: "archived")
  end

  def display_title
    title.presence || "Conversation ##{id}"
  end
end
