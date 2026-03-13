module Admin
  class UsersController < BaseController
    def index
      @users = User.order(created_at: :desc)
      @users = @users.where("email ILIKE ? OR full_name ILIKE ?", "%#{params[:q]}%", "%#{params[:q]}%") if params[:q].present?
      @users = @users.page(params[:page]).per(25)
    end

    def show
      @user = User.find(params[:id])
      @recent_activity = AuditLog.where(user: @user).recent.limit(10)
    end

    def toggle_admin
      @user = User.find(params[:id])

      if @user == current_user
        redirect_to admin_users_path, alert: "You cannot modify your own admin status."
        return
      end

      @user.update!(admin: !@user.admin, admin_role: @user.admin? ? "none" : "admin")
      audit!("toggle_admin", resource: @user, metadata: { admin: @user.admin })
      redirect_to admin_user_path(@user), notice: "Admin status updated for #{@user.email}."
    end

    def toggle_subscription
      @user = User.find(params[:id])
      subscription = @user.subscription

      if subscription&.active?
        subscription.update!(status: :cancelled, cancelled_at: Time.current)
        audit!("cancel_subscription", resource: @user)
        redirect_to admin_user_path(@user), notice: "Subscription cancelled."
      else
        redirect_to admin_user_path(@user), alert: "No active subscription to cancel."
      end
    end
  end
end
