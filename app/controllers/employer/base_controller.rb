module Employer
  class BaseController < ApplicationController
    before_action :require_employer_auth!
    before_action :require_employer!
    layout "employer"

    private

    def require_employer_auth!
      unless user_signed_in?
        session[:login_intent] = "employer"
        redirect_to employer_login_path, alert: "Please sign in to access the employer portal."
        return
      end
    end

    def require_employer!
      unless current_employer
        redirect_to employer_onboarding_path, alert: "Please set up your company profile first."
      end
    end

    def current_employer
      @current_employer ||= current_user.employer_profile
    end
    helper_method :current_employer
  end
end
