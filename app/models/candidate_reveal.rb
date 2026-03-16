class CandidateReveal < ApplicationRecord
  belongs_to :employer_profile
  belongs_to :user

  validates :user_id, uniqueness: { scope: :employer_profile_id }
end
