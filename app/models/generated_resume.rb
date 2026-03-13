class GeneratedResume < ApplicationRecord
  belongs_to :user

  enum :status, { pending: 0, generating: 1, completed: 2, failed: 3 }

  scope :recent, -> { order(created_at: :desc) }
end
