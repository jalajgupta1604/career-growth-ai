class InterviewDebriefsController < ApplicationController
  before_action :authenticate_user!

  def index
    @debriefs = InterviewDebriefService.new(current_user).recent_debriefs
  end

  def new
    @debrief = InterviewDebrief.new
  end

  def create
    service = InterviewDebriefService.new(current_user)
    @debrief = service.create_debrief(debrief_params)
    redirect_to interview_debrief_path(@debrief), notice: "Interview debrief created and analysis started!"
  rescue => e
    Rails.logger.error("Debrief creation failed: #{e.message}")
    @debrief = InterviewDebrief.new
    flash.now[:alert] = "Failed to create debrief. Please try again."
    render :new, status: :unprocessable_entity
  end

  def show
    @debrief = current_user.interview_debriefs.find(params[:id])
  end

  private

  def debrief_params
    params.require(:interview_debrief).permit(:company_name, :role_applied, :interview_date, :questions_text, :user_notes)
  end
end
