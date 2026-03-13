class Invoice < ApplicationRecord
  belongs_to :user
  belongs_to :payment, optional: true

  validates :invoice_number, presence: true, uniqueness: true
  validates :amount, presence: true
  validates :total_amount, presence: true

  scope :recent, -> { order(created_at: :desc) }

  before_validation :generate_invoice_number, on: :create

  def self.generate_for_payment(payment)
    tax_rate = 0.18
    tax = (payment.amount * tax_rate).round
    create!(
      user: payment.user,
      payment: payment,
      amount: payment.amount,
      tax_amount: tax,
      total_amount: payment.amount + tax,
      status: "paid",
      issued_at: Time.current,
      paid_at: Time.current,
      line_items: [
        { description: "Career Growth AI Pro Subscription", amount: payment.amount }
      ]
    )
  end

  private

  def generate_invoice_number
    self.invoice_number ||= "INV-#{Date.current.strftime('%Y%m')}-#{SecureRandom.alphanumeric(6).upcase}"
  end
end
