class PeerPracticeController < ApplicationController
  before_action :authenticate_user!

  def index
    @available_sessions = PeerPracticeSession.available.includes(:user).recent.limit(20)
    @my_sessions = current_user.peer_practice_sessions.recent.limit(10)
    @upcoming = PeerPracticeSession.where("user_id = ? OR partner_id = ?", current_user.id, current_user.id).upcoming.limit(5)
  end

  def create
    @session = current_user.peer_practice_sessions.build(session_params)
    @session.status = :pending
    if @session.save
      redirect_to peer_practice_index_path, notice: "Practice session created! Waiting for a match."
    else
      redirect_to peer_practice_index_path, alert: @session.errors.full_messages.join(", ")
    end
  end

  def join
    @session = PeerPracticeSession.find(params[:id])
    if @session.can_join?(current_user)
      @session.update!(partner: current_user, status: :matched, scheduled_at: Time.current + 1.hour)
      redirect_to peer_practice_index_path, notice: "Matched! Session scheduled."
    else
      redirect_to peer_practice_index_path, alert: "Cannot join this session."
    end
  end

  def feedback
    @session = PeerPracticeSession.find(params[:id])
    return redirect_to peer_practice_index_path, alert: "Not authorized" unless [@session.user_id, @session.partner_id].include?(current_user.id)

    existing = @session.feedback_data || {}
    existing[current_user.id.to_s] = {
      "rating" => params[:rating].to_i,
      "comments" => params[:comments],
      "submitted_at" => Time.current.iso8601
    }
    @session.update!(feedback_data: existing, status: :completed)
    redirect_to peer_practice_index_path, notice: "Feedback submitted!"
  end

  private

  def session_params
    params.require(:peer_practice_session).permit(:session_type, :target_company, :target_role, :notes)
  end
end
