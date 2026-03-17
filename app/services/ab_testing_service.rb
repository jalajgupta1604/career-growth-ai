class AbTestingService
  def initialize(user)
    @user = user
  end

  # Get the variant for a user in a given experiment
  def variant_for(experiment_name)
    experiment = Experiment.find_by(name: experiment_name)
    return nil unless experiment&.running?

    experiment.assign_variant(@user)
  end

  # Track a conversion event
  def convert!(experiment_name)
    experiment = Experiment.find_by(name: experiment_name)
    return false unless experiment

    experiment.convert!(@user)
  end

  # Check if user is in a specific variant
  def in_variant?(experiment_name, variant)
    variant_for(experiment_name) == variant
  end

  # Helper for creating experiments
  def self.create_experiment(name:, variants:, metric:, description: nil, traffic_percentage: 100)
    Experiment.create!(
      name: name,
      variants: variants,
      metric: metric,
      description: description,
      traffic_percentage: traffic_percentage,
      status: "draft"
    )
  end

  # Get results for an experiment
  def self.results(experiment_name)
    experiment = Experiment.find_by!(name: experiment_name)
    {
      name: experiment.name,
      status: experiment.status,
      variants: experiment.variant_stats,
      started_at: experiment.started_at,
      ended_at: experiment.ended_at
    }
  end
end
