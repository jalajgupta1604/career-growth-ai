class CompanyMember < ApplicationRecord
  belongs_to :company
  belongs_to :user

  validates :company_id, uniqueness: { scope: :user_id }
  validates :role, inclusion: { in: %w[admin member viewer] }

  scope :admins, -> { where(role: "admin") }
  scope :members, -> { where(role: "member") }

  def admin?
    role == "admin"
  end
end
