class StudyGroupMembership < ApplicationRecord
  belongs_to :study_group
  belongs_to :user

  validates :user_id, uniqueness: { scope: :study_group_id, message: "is already a member" }
  validates :role, inclusion: { in: %w[admin member] }
end
