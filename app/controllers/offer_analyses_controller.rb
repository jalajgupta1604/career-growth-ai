class OfferAnalysesController < ApplicationController
  before_action :authenticate_user!
  before_action :require_subscription!

  def index
    @analyses = current_user.offer_analyses.recent.limit(10)
  end

  def new
  end

  def create
    service = OfferAnalysisService.new(current_user)
    @analysis = service.analyze(offer_params)
    redirect_to offer_analysis_path(@analysis), notice: "Offer analyzed!"
  rescue => e
    Rails.logger.error("Offer analysis failed: #{e.message}")
    redirect_to new_offer_analysis_path, alert: "Failed to analyze offer. Please try again."
  end

  def show
    @analysis = current_user.offer_analyses.find(params[:id])
    @data = @analysis.analysis_data || {}
  end

  private

  def offer_params
    params.require(:offer_analysis).permit(:company_name, :offer_role, :base_salary, :total_ctc, :components)
  end

  def require_subscription!
    return if current_user.subscribed?
    redirect_to pricing_path, alert: "Offer Analysis is a Pro feature. Please subscribe to access."
  end
end
