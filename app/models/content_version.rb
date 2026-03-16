class ContentVersion < ApplicationRecord
  belongs_to :cms_content
  belongs_to :author, class_name: "User"

  validates :version_number, presence: true, uniqueness: { scope: :cms_content_id }

  scope :ordered, -> { order(version_number: :desc) }
end
