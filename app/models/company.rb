class Company < ApplicationRecord
  has_many :company_members, dependent: :destroy
  has_many :users, through: :company_members
  has_many :company_analytics_snapshots, dependent: :destroy

  validates :name, presence: true
  validates :domain, uniqueness: true, allow_nil: true

  scope :active_companies, -> { where(active: true) }

  def admins
    company_members.where(role: "admin").includes(:user).map(&:user)
  end

  def members
    company_members.where(role: "member").includes(:user).map(&:user)
  end

  def team_size
    company_members.count
  end

  def latest_snapshot
    company_analytics_snapshots.order(created_at: :desc).first
  end
end
