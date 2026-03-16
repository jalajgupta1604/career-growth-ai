class Payment < ApplicationRecord
  belongs_to :user
  belongs_to :career_report
  belongs_to :refunded_by, class_name: "User", optional: true

  enum :status, { pending: 0, captured: 1, failed: 2, refunded: 3 }

  validates :amount, presence: true, numericality: { greater_than: 0 }

  scope :refundable, -> { where(status: :captured) }
end
