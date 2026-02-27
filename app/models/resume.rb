class Resume < ApplicationRecord
  belongs_to :user
  has_one_attached :file

  enum :parsing_status, { pending: 0, processing: 1, completed: 2, failed: 3 }

  validates :user, presence: true
end
