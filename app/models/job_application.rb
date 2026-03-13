class JobApplication < ApplicationRecord
  belongs_to :user
  belongs_to :job_posting

  enum :status, { applied: 0, shortlisted: 1, interviewing: 2, offered: 3, rejected: 4, withdrawn: 5 }

  validates :user_id, uniqueness: { scope: :job_posting_id, message: "has already applied" }

  scope :recent, -> { order(created_at: :desc) }
end
