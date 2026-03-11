class OfferAnalysis < ApplicationRecord
  belongs_to :user

  validates :user, presence: true
  validates :company_name, presence: true
  validates :base_salary, presence: true, numericality: { greater_than: 0 }

  scope :recent, -> { order(created_at: :desc) }

  def verdict_color
    case verdict
    when "strong_accept" then "green"
    when "accept" then "cyan"
    when "negotiate" then "yellow"
    when "caution" then "orange"
    when "decline" then "red"
    else "gray"
    end
  end
end
