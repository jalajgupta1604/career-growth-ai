class StudyGroup < ApplicationRecord
  belongs_to :creator, class_name: "User"
  has_many :study_group_memberships, dependent: :destroy
  has_many :members, through: :study_group_memberships, source: :user

  validates :name, presence: true

  scope :recent, -> { order(created_at: :desc) }
  scope :with_space, -> { joins("LEFT JOIN study_group_memberships ON study_group_memberships.study_group_id = study_groups.id").group("study_groups.id").having("COUNT(study_group_memberships.id) < study_groups.max_members") }

  def full?
    study_group_memberships.count >= max_members
  end

  def member?(user)
    study_group_memberships.exists?(user: user)
  end

  def member_count
    study_group_memberships.count
  end
end
