class Notification < ApplicationRecord
  belongs_to :user

  validates :title, presence: true
  validates :category, presence: true, inclusion: { in: %w[system achievement subscription interview career community] }

  scope :unread, -> { where(read_at: nil) }
  scope :recent, -> { order(created_at: :desc) }
  scope :by_category, ->(cat) { where(category: cat) }

  def read?
    read_at.present?
  end

  def mark_as_read!
    update!(read_at: Time.current) unless read?
  end
end
