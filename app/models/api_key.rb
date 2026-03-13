class ApiKey < ApplicationRecord
  belongs_to :user

  validates :key, presence: true, uniqueness: true
  validates :name, presence: true
  validates :tier, inclusion: { in: %w[free starter enterprise] }

  scope :active, -> { where(active: true) }

  before_validation :generate_key, on: :create

  def increment_usage!
    increment!(:calls_count)
  end

  def within_rate_limit?
    calls_count < rate_limit
  end

  private

  def generate_key
    self.key ||= "cgai_#{SecureRandom.hex(24)}"
  end
end
