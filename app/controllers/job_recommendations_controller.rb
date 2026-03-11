class JobRecommendationsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_subscription!

  def index
    service = JobRecommendationService.new(current_user)
    @data = service.dashboard_data
  end

  def generate
    service = JobRecommendationService.new(current_user)
    service.ai_recommendations
    redirect_to job_recommendations_path, notice: "Job recommendations generated successfully!"
  rescue => e
    Rails.logger.error("Job recommendations failed: #{e.message}")
    redirect_to job_recommendations_path, alert: "Failed to generate recommendations. Please try again."
  end

  def show
    @recommendation = current_user.job_recommendations.includes(:job_listing).find(params[:id])
    @recommendation.mark_viewed!
  end

  def save
    @recommendation = current_user.job_recommendations.find(params[:id])
    @recommendation.save_job!
    redirect_to job_recommendations_path, notice: "Job saved!"
  end

  def apply
    @recommendation = current_user.job_recommendations.find(params[:id])
    @recommendation.mark_applied!
    redirect_to job_recommendation_path(@recommendation), notice: "Marked as applied!"
  end

  private

  def require_subscription!
    return if current_user.subscribed?
    redirect_to pricing_path, alert: "Job Recommendations is a Pro feature. Please subscribe to access."
  end
end
