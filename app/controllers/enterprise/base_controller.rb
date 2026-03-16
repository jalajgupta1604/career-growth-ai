module Enterprise
  class BaseController < ApplicationController
    before_action :authenticate_user!
    before_action :set_company
    layout "enterprise"

    private

    def set_company
      @company = current_user.companies.first
      unless @company
        redirect_to dashboard_path, alert: "You are not part of any enterprise team."
      end
    end

    def current_member
      @current_member ||= @company&.company_members&.find_by(user: current_user)
    end
    helper_method :current_member

    def require_hr_admin!
      unless current_member&.hr_admin?
        redirect_to enterprise_root_path, alert: "Only HR admins can perform this action."
      end
    end

    def require_manager_or_above!
      unless current_member&.hr_admin? || current_member&.manager?
        redirect_to enterprise_root_path, alert: "You need manager or admin access."
      end
    end
  end
end
