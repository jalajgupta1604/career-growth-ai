class ContentFlag < ApplicationRecord
  belongs_to :user
  belongs_to :flaggable, polymorphic: true
  belongs_to :resolved_by, class_name: "User", optional: true

  enum :status, { pending: 0, reviewing: 1, resolved: 2, dismissed: 3 }

  validates :reason, presence: true

  scope :unresolved, -> { where(status: [:pending, :reviewing]) }
  scope :recent, -> { order(created_at: :desc) }

  def resolve!(admin, notes: nil)
    update!(status: :resolved, resolved_by: admin, notes: notes)
  end

  def dismiss!(admin, notes: nil)
    update!(status: :dismissed, resolved_by: admin, notes: notes)
  end
end
