class CareerCoachController < ApplicationController
  before_action :authenticate_user!
  before_action :require_subscription!

  def index
    service = CareerCoachService.new(current_user)
    @conversations = service.conversations_list
    @suggested_topics = service.suggested_topics
  end

  def show
    @conversation = current_user.coach_conversations.find(params[:id])
    @messages = @conversation.coach_messages.ordered
  end

  def create
    service = CareerCoachService.new(current_user)
    @conversation = service.start_conversation(topic: params[:topic])
    redirect_to career_coach_path(@conversation)
  rescue => e
    Rails.logger.error("Career coach conversation failed: #{e.message}")
    redirect_to career_coach_index_path, alert: "Failed to start conversation. Please try again."
  end

  def message
    @conversation = current_user.coach_conversations.find(params[:id])
    content = params[:content].to_s.strip

    if content.blank?
      redirect_to career_coach_path(@conversation), alert: "Please enter a message."
      return
    end

    service = CareerCoachService.new(current_user)
    service.send_message(@conversation, content)
    redirect_to career_coach_path(@conversation)
  rescue => e
    Rails.logger.error("Career coach message failed: #{e.message}")
    redirect_to career_coach_path(@conversation), alert: "Failed to send message. Please try again."
  end

  def archive
    @conversation = current_user.coach_conversations.find(params[:id])
    @conversation.archive!
    redirect_to career_coach_index_path, notice: "Conversation archived."
  end

  private

  def require_subscription!
    return if current_user.subscribed?
    redirect_to pricing_path, alert: "AI Career Coach is a Pro feature. Please subscribe to access."
  end
end
