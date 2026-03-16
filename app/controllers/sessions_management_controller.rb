class SessionsManagementController < ApplicationController
  before_action :authenticate_user!

  def index
    @sessions = current_user.user_sessions.active.recent
  end

  def destroy
    session_record = current_user.user_sessions.find(params[:id])
    session_record.destroy
    redirect_to sessions_management_index_path, notice: "Session revoked."
  end

  def destroy_all
    current_user.user_sessions.where.not(session_token: session.id.to_s).destroy_all
    redirect_to sessions_management_index_path, notice: "All other sessions revoked."
  end
end
