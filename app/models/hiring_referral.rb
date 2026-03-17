class HiringReferral < ApplicationRecord
  belongs_to :referrer, class_name: "User"
  belongs_to :candidate, class_name: "User"
  belongs_to :job_posting
  belongs_to :employer_profile

  validates :referrer_id, uniqueness: { scope: [:candidate_id, :job_posting_id] }

  scope :recent, -> { order(created_at: :desc) }
  scope :pending_commission, -> { where(commission_status: "pending").where.not(commission_amount: nil) }

  STATUSES = %w[referred interviewing hired rejected withdrawn].freeze

  def mark_hired!(commission: nil)
    update!(
      status: "hired",
      hired_at: Time.current,
      commission_amount: commission || calculate_commission,
      commission_status: "pending"
    )
  end

  def pay_commission!
    update!(commission_status: "paid", commission_paid_at: Time.current)
  end

  private

  def calculate_commission
    # Default 2% of job posting salary or flat 5000
    posting_salary = job_posting.respond_to?(:max_salary) ? job_posting.max_salary : nil
    posting_salary ? (posting_salary * 0.02).round(2) : 5000.00
  end
end
