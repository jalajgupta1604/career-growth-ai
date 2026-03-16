class Department < ApplicationRecord
  belongs_to :company
  belongs_to :head, class_name: "User", optional: true
  belongs_to :parent_department, class_name: "Department", optional: true

  has_many :sub_departments, class_name: "Department", foreign_key: :parent_department_id, dependent: :nullify
  has_many :company_members, dependent: :nullify

  validates :name, presence: true, uniqueness: { scope: :company_id }

  scope :top_level, -> { where(parent_department_id: nil) }

  def member_count
    company_members.count
  end
end
