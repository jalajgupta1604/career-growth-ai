module Employer
  class BaseController < ApplicationController
    before_action :authenticate_user!
    before_action :require_employer!
    layout "employer"

    private

    def require_employer!
      unless current_employer
        redirect_to employer_registration_path, alert: "Please register as an employer first."
      end
    end

    def current_employer
      @current_employer ||= current_user.employer_profile
    end
    helper_method :current_employer
  end
end
