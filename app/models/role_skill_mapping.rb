class RoleSkillMapping < ApplicationRecord
  belongs_to :skill

  validates :role, presence: true
  validates :importance_weight, numericality: { greater_than: 0, less_than_or_equal_to: 1 }, allow_nil: true

  scope :for_role, ->(role) { where(role: role) }
end
