class Experiment < ApplicationRecord
  has_many :experiment_assignments, dependent: :destroy

  validates :name, presence: true, uniqueness: true
  validates :metric, presence: true
  validates :variants, presence: true

  scope :active, -> { where(status: "running") }
  scope :recent, -> { order(created_at: :desc) }

  def running?
    status == "running"
  end

  def assign_variant(user)
    return nil unless running?

    existing = experiment_assignments.find_by(user: user)
    return existing.variant if existing

    return nil if rand(100) >= traffic_percentage

    variant = variants.sample
    experiment_assignments.create!(user: user, variant: variant)
    variant
  end

  def convert!(user)
    assignment = experiment_assignments.find_by(user: user)
    return false unless assignment && !assignment.converted

    assignment.update!(converted: true, converted_at: Time.current)
    true
  end

  def variant_stats
    variants.each_with_object({}) do |variant, stats|
      assignments = experiment_assignments.where(variant: variant)
      total = assignments.count
      converted = assignments.where(converted: true).count
      stats[variant] = {
        total: total,
        converted: converted,
        conversion_rate: total > 0 ? (converted.to_f / total * 100).round(2) : 0
      }
    end
  end

  def start!
    update!(status: "running", started_at: Time.current)
  end

  def stop!
    update!(status: "completed", ended_at: Time.current, results: variant_stats)
  end
end
