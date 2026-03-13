module Admin
  class BaseController < ApplicationController
    before_action :authenticate_user!
    before_action :require_admin!
    layout "admin"

    private

    def require_admin!
      unless current_user.admin?
        redirect_to dashboard_path, alert: "You don't have access to the admin panel."
      end
    end

    def require_super_admin!
      unless current_user.super_admin?
        redirect_to admin_root_path, alert: "Only super admins can perform this action."
      end
    end

    def audit!(action, resource: nil, metadata: {})
      AuditLog.track(
        user: current_user,
        action: action,
        resource: resource,
        metadata: metadata,
        ip_address: request.remote_ip
      )
    end
  end
end
