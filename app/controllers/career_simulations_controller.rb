class CareerSimulationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @simulations = current_user.career_simulations.recent.limit(20)
  end

  def new
    @simulation = CareerSimulation.new
  end

  def create
    service = CareerSimulationService.new(current_user)
    @simulation = service.simulate(scenario_params)
    if @simulation.completed?
      redirect_to career_simulation_path(@simulation), notice: "Simulation complete!"
    else
      redirect_to career_simulations_path, alert: "Simulation failed. Please try again."
    end
  end

  def show
    @simulation = current_user.career_simulations.find(params[:id])
  end

  private

  def scenario_params
    params.permit(:scenario_type, :description, :target_role, :target_company_type)
  end
end
