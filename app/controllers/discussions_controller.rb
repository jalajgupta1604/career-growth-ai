class DiscussionsController < ApplicationController
  before_action :authenticate_user!

  def index
    @category = params[:category]
    @threads = DiscussionThread.recent.includes(:user)
    @threads = @threads.by_category(@category) if @category.present?
    @threads = @threads.limit(30)
  end

  def show
    @thread = DiscussionThread.find(params[:id])
    @replies = @thread.discussion_replies.recent.includes(:user)
  end

  def create
    @thread = current_user.discussion_threads.build(thread_params)
    if @thread.save
      redirect_to discussion_path(@thread), notice: "Thread created!"
    else
      redirect_to discussions_path, alert: @thread.errors.full_messages.join(", ")
    end
  end

  def reply
    @thread = DiscussionThread.find(params[:id])
    @reply = @thread.discussion_replies.build(user: current_user, body: params[:body])
    if @reply.save
      redirect_to discussion_path(@thread), notice: "Reply posted!"
    else
      redirect_to discussion_path(@thread), alert: "Reply cannot be empty."
    end
  end

  private

  def thread_params
    params.require(:discussion_thread).permit(:title, :body, :category)
  end
end
