module Employer
  class SessionsController < ApplicationController
    def new
      if user_signed_in?
        if current_user.employer_profile.present?
          redirect_to employer_root_path
        else
          redirect_to employer_onboarding_path
        end
      else
        session[:login_intent] = "employer"
        redirect_to new_user_session_path
      end
    end
  end
end
