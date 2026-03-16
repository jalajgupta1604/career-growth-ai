class EmployerProfile < ApplicationRecord
  belongs_to :user
  has_many :candidate_searches, dependent: :destroy
  has_many :job_postings, dependent: :nullify
  has_many :candidate_reveals, dependent: :destroy

  validates :company_name, presence: true
  validates :company_size, inclusion: { in: %w[1-10 11-50 51-200 201-500 501-1000 1000+] }, allow_blank: true
  validates :slug, uniqueness: true, allow_blank: true

  scope :verified, -> { where(verified: true) }

  before_validation :generate_slug, on: :create

  BILLING_PLANS = {
    "free" => { reveal_credits: 5, job_posts: 2, price: 0 },
    "starter" => { reveal_credits: 50, job_posts: 10, price: 2999 },
    "professional" => { reveal_credits: 200, job_posts: 50, price: 9999 }
  }.freeze

  def verify!
    update!(verified: true, verified_at: Time.current, verification_token: nil)
  end

  def generate_verification_token!
    update!(verification_token: SecureRandom.hex(20))
  end

  def revealed?(user)
    candidate_reveals.exists?(user_id: user.id)
  end

  def reveal!(user)
    return true if revealed?(user)
    raise "No reveal credits remaining" if candidate_reveal_credits <= 0

    transaction do
      candidate_reveals.create!(user: user)
      decrement!(:candidate_reveal_credits)
    end
  end

  def active_job_limit
    (BILLING_PLANS[billing_plan || "free"] || BILLING_PLANS["free"])[:job_posts]
  end

  private

  def generate_slug
    return if slug.present?
    base = company_name.to_s.parameterize
    self.slug = base
    counter = 1
    while EmployerProfile.exists?(slug: self.slug)
      self.slug = "#{base}-#{counter}"
      counter += 1
    end
  end
end
