class CompanyMember < ApplicationRecord
  belongs_to :company
  belongs_to :user
  belongs_to :department, optional: true
  belongs_to :manager, class_name: "CompanyMember", optional: true

  has_many :direct_reports, class_name: "CompanyMember", foreign_key: :manager_id, dependent: :nullify

  validates :company_id, uniqueness: { scope: :user_id }
  validates :role, inclusion: { in: %w[hr_admin manager employee viewer admin member] }
  validates :employment_status, inclusion: { in: %w[active inactive on_leave terminated] }, allow_nil: true

  scope :active, -> { where(employment_status: "active") }
  scope :hr_admins, -> { where(role: "hr_admin") }
  scope :managers, -> { where(role: "manager") }

  def hr_admin?
    role == "hr_admin" || role == "admin"
  end

  def manager?
    role == "manager"
  end

  def employee?
    role == "employee" || role == "member"
  end

  def admin?
    hr_admin?
  end
end
