class InterviewExperiencesController < ApplicationController
  before_action :authenticate_user!

  def index
    service = InterviewExperienceService.new(current_user)
    @data = service.explore(filter_params)
    @filters = filter_params
  end

  def new
  end

  def create
    service = InterviewExperienceService.new(current_user)
    service.submit(experience_params)
    redirect_to interview_experiences_path, notice: "Interview experience shared! Thank you for contributing."
  rescue => e
    Rails.logger.error("Interview experience submission failed: #{e.message}")
    redirect_to new_interview_experience_path, alert: "Failed to submit experience. Please check your inputs."
  end

  def show
    @experience = InterviewExperience.find(params[:id])
  end

  private

  def experience_params
    params.require(:interview_experience).permit(:company_name, :role, :difficulty, :outcome, :rounds_count, :overall_rating, :experience_summary, :rounds_data, :tags, :anonymous)
  end

  def filter_params
    params.permit(:company_name, :role, :difficulty, :outcome)
  end
end
