class CareerReport < ApplicationRecord
  belongs_to :user
  has_one :payment, dependent: :destroy

  enum :payment_status, { unpaid: 0, paid: 1, refunded: 2 }

  validates :user, presence: true

  def paid?
    payment_status == "paid"
  end

  def downloadable?
    user.subscribed?
  end
end
