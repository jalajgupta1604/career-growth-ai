class InterviewSimulatorController < ApplicationController
  before_action :authenticate_user!
  before_action :require_subscription!
  before_action :set_interview, only: [:show, :answer]

  def new
    @company_styles = InterviewSimulatorService::COMPANY_STYLES
  end

  def create
    service = InterviewSimulatorService.new(current_user)
    @interview = service.create_simulation(
      interview_type: params[:interview_type] || "technical",
      difficulty: params[:difficulty] || "medium",
      company_style: params[:company_style] || "general"
    )
    redirect_to interview_simulator_path(@interview)
  rescue => e
    Rails.logger.error("Interview simulator creation failed: #{e.message}")
    redirect_to new_interview_simulator_path, alert: "Failed to start simulation. Please try again."
  end

  def show
    @question = @interview.current_question
    @responses = @interview.responses_data || []
    @follow_ups = @interview.follow_up_data || {}
    @scorecard = @interview.scorecard_data if @interview.completed?
    @company = InterviewSimulatorService::COMPANY_STYLES[@interview.company_style] || InterviewSimulatorService::COMPANY_STYLES["general"]
  end

  def answer
    answer_text = params[:answer].to_s.strip
    if answer_text.blank?
      redirect_to interview_simulator_path(@interview), alert: "Please provide an answer."
      return
    end

    service = InterviewSimulatorService.new(current_user)
    service.submit_answer_with_follow_up(@interview, answer_text)
    @interview.reload

    if @interview.completed?
      redirect_to interview_simulator_path(@interview), notice: "Simulation complete! Review your scorecard."
    else
      redirect_to interview_simulator_path(@interview), notice: "Answer evaluated. Next question ready."
    end
  rescue => e
    Rails.logger.error("Simulator answer failed: #{e.message}")
    redirect_to interview_simulator_path(@interview), alert: "Failed to process answer. Please try again."
  end

  private

  def set_interview
    @interview = current_user.mock_interviews.where(simulator_mode: true).find(params[:id])
  end

  def require_subscription!
    return if current_user.subscribed?
    redirect_to pricing_path, alert: "AI Interview Simulator is a Pro feature. Please subscribe to access."
  end
end
