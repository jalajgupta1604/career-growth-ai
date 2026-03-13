class NotificationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @notifications = current_user.notifications.recent.page(params[:page]).per(20)
  end

  def mark_as_read
    notification = current_user.notifications.find(params[:id])
    notification.mark_as_read!
    redirect_back fallback_location: notifications_path
  end

  def mark_all_read
    current_user.notifications.unread.update_all(read_at: Time.current)
    redirect_to notifications_path, notice: "All notifications marked as read."
  end
end
