class NegotiationsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_subscription!

  def index
    @sessions = current_user.negotiation_sessions.recent.limit(10)
  end

  def new
  end

  def create
    service = NegotiationService.new(current_user)
    @session = service.generate(negotiation_params)
    redirect_to negotiation_path(@session), notice: "Negotiation strategy generated!"
  rescue => e
    Rails.logger.error("Negotiation generation failed: #{e.message}")
    redirect_to new_negotiation_path, alert: "Failed to generate strategy. Please try again."
  end

  def show
    @session = current_user.negotiation_sessions.find(params[:id])
    @strategy = @session.strategy_data || {}
  end

  private

  def negotiation_params
    params.require(:negotiation_session).permit(:current_offer, :expected_salary, :company_name, :offer_role, :benefits)
  end

  def require_subscription!
    return if current_user.subscribed?
    redirect_to pricing_path, alert: "Salary Negotiation Tool is a Pro feature. Please subscribe to access."
  end
end
