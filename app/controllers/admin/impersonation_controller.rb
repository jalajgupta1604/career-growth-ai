module Admin
  class ImpersonationController < BaseController
    before_action :require_super_admin!

    def create
      target = User.find(params[:user_id])

      if target.admin?
        redirect_to admin_user_path(target), alert: "Cannot impersonate admin users."
        return
      end

      if params[:reason].blank?
        redirect_to admin_user_path(target), alert: "Reason is required for impersonation."
        return
      end

      log = ImpersonationLog.create!(
        admin: current_user,
        target_user: target,
        reason: params[:reason],
        started_at: Time.current,
        ip_address: request.remote_ip
      )

      audit!("impersonate_user", resource: target, metadata: { reason: params[:reason], log_id: log.id })

      session[:admin_id] = current_user.id
      session[:impersonation_log_id] = log.id
      sign_in(:user, target)

      redirect_to dashboard_path, notice: "Now viewing as #{target.email}. Click 'Stop Impersonation' in the banner to return."
    end

    def destroy
      log = ImpersonationLog.find(session[:impersonation_log_id])
      admin = User.find(session[:admin_id])

      log.end!

      session.delete(:admin_id)
      session.delete(:impersonation_log_id)
      sign_in(:user, admin)

      redirect_to admin_user_path(log.target_user), notice: "Impersonation ended."
    end
  end
end
