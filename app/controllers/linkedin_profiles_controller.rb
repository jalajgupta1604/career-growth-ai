class LinkedinProfilesController < ApplicationController
  before_action :authenticate_user!
  before_action :require_subscription!

  def show
    service = LinkedinService.new(current_user)
    @profile = current_user.linkedin_profile
    @insights = service.profile_insights
  end

  def new
    @profile = current_user.linkedin_profile || current_user.build_linkedin_profile
  end

  def create
    service = LinkedinService.new(current_user)
    @profile = service.manual_import(linkedin_params)
    redirect_to linkedin_profile_path, notice: "LinkedIn profile imported successfully!"
  rescue => e
    Rails.logger.error("LinkedIn import failed: #{e.message}")
    redirect_to new_linkedin_profile_path, alert: "Failed to import LinkedIn profile. Please try again."
  end

  private

  def linkedin_params
    params.require(:linkedin_profile).permit(:linkedin_url, :headline, :industry, :location, :positions_text, :skills_text)
  end

  def require_subscription!
    return if current_user.subscribed?
    redirect_to pricing_path, alert: "LinkedIn Integration is a Pro feature. Please subscribe to access."
  end
end
