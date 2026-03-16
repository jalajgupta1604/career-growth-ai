module Employer
  class RegistrationsController < ApplicationController
    before_action :require_employer_login!
    layout "employer_public"

    def new
      if current_user.employer_profile.present?
        redirect_to employer_root_path
        return
      end
      @employer_profile = EmployerProfile.new
    end

    def create
      @employer_profile = current_user.build_employer_profile(employer_params)

      if @employer_profile.save
        @employer_profile.generate_verification_token!
        redirect_to employer_root_path, notice: "Welcome! Your employer profile has been created."
      else
        render :new, status: :unprocessable_entity
      end
    end

    private

    def require_employer_login!
      unless user_signed_in?
        session[:login_intent] = "employer"
        redirect_to employer_login_path, alert: "Please sign in to set up your employer profile."
      end
    end

    def employer_params
      params.require(:employer_profile).permit(:company_name, :company_domain, :company_size, :industry, :company_description)
    end
  end
end
