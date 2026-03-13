module Admin
  class AuditLogsController < BaseController
    def index
      @audit_logs = AuditLog.recent.includes(:user)
      @audit_logs = @audit_logs.by_action(params[:action_filter]) if params[:action_filter].present?
      @audit_logs = @audit_logs.page(params[:page]).per(30)
    end
  end
end
