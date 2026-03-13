class ScheduledChallenge < ApplicationRecord
  belongs_to :cms_content, optional: true

  validates :title, presence: true
  validates :scheduled_for, uniqueness: true, allow_nil: true
  validates :difficulty, inclusion: { in: %w[easy medium hard] }

  scope :upcoming, -> { where("scheduled_for >= ?", Date.current).order(scheduled_for: :asc) }
  scope :published, -> { where(published: true) }
  scope :for_date, ->(date) { where(scheduled_for: date) }

  def self.today
    for_date(Date.current).published.first
  end
end
