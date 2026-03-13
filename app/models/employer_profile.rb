class EmployerProfile < ApplicationRecord
  belongs_to :user
  has_many :candidate_searches, dependent: :destroy
  has_many :job_postings, dependent: :nullify

  validates :company_name, presence: true
  validates :company_size, inclusion: { in: %w[startup mid large enterprise] }, allow_blank: true

  scope :verified, -> { where(verified: true) }

  def verify!
    update!(verified: true, verified_at: Time.current, verification_token: nil)
  end

  def generate_verification_token!
    update!(verification_token: SecureRandom.hex(20))
  end
end
