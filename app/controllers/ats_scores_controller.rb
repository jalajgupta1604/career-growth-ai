class AtsScoresController < ApplicationController
  before_action :authenticate_user!
  before_action :require_subscription!

  def show
    @resume = current_user.resumes.where(parsing_status: :completed).order(created_at: :desc).first

    unless @resume
      redirect_to dashboard_path, alert: "Please upload and parse a resume first."
      return
    end

    @ats_data = @resume.ats_data.presence || {}
    @ats_score = @resume.ats_score
  end

  def create
    @resume = current_user.resumes.where(parsing_status: :completed).order(created_at: :desc).first

    unless @resume
      redirect_to dashboard_path, alert: "Please upload and parse a resume first."
      return
    end

    service = AtsScoringService.new(@resume)
    service.score
    redirect_to ats_score_path, notice: "ATS score calculated!"
  rescue => e
    Rails.logger.error("ATS scoring failed: #{e.message}")
    redirect_to ats_score_path, alert: "Failed to calculate ATS score. Please try again."
  end

  private

  def require_subscription!
    return if current_user.subscribed?
    redirect_to pricing_path, alert: "ATS Scoring is a Pro feature. Please subscribe to access."
  end
end
