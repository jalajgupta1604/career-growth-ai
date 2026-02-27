class Skill < ApplicationRecord
  has_many :role_skill_mappings, dependent: :destroy

  validates :name, presence: true, uniqueness: true
  validates :category, presence: true
  validates :demand_index, :salary_uplift_index, :learning_difficulty_index,
            numericality: { greater_than: 0 }, allow_nil: true

  def roi_score
    return 0 if learning_difficulty_index.to_f.zero?
    (salary_uplift_index.to_f * demand_index.to_f) / learning_difficulty_index.to_f
  end
end
