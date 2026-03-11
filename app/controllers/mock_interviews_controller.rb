class MockInterviewsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_subscription!
  before_action :set_interview, only: [:show, :answer]

  def index
    service = MockInterviewService.new(current_user)
    @data = service.dashboard_data
  end

  def new
  end

  def create
    service = MockInterviewService.new(current_user)
    @interview = service.create_interview(
      interview_type: params[:interview_type] || "technical",
      difficulty: params[:difficulty] || "medium"
    )
    redirect_to mock_interview_path(@interview)
  rescue => e
    Rails.logger.error("Mock interview creation failed: #{e.message}")
    redirect_to mock_interviews_path, alert: "Failed to create mock interview. Please try again."
  end

  def show
    @question = @interview.current_question
    @responses = @interview.responses_data || []
  end

  def answer
    answer_text = params[:answer].to_s.strip
    if answer_text.blank?
      redirect_to mock_interview_path(@interview), alert: "Please provide an answer."
      return
    end

    service = MockInterviewService.new(current_user)
    @feedback = service.submit_answer(@interview, answer_text)
    @interview.reload

    if @interview.completed?
      redirect_to mock_interview_path(@interview), notice: "Interview completed! Review your results."
    else
      redirect_to mock_interview_path(@interview), notice: "Answer submitted. Next question ready."
    end
  rescue => e
    Rails.logger.error("Mock interview answer failed: #{e.message}")
    redirect_to mock_interview_path(@interview), alert: "Failed to process answer. Please try again."
  end

  private

  def set_interview
    @interview = current_user.mock_interviews.find(params[:id])
  end

  def require_subscription!
    return if current_user.subscribed?
    redirect_to pricing_path, alert: "Mock Interviews are a Pro feature. Please subscribe to access."
  end
end
