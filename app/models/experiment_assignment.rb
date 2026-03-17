class ExperimentAssignment < ApplicationRecord
  belongs_to :experiment
  belongs_to :user

  validates :variant, presence: true
  validates :user_id, uniqueness: { scope: :experiment_id }
end
