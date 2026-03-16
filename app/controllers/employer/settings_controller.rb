module Employer
  class SettingsController < BaseController
    def show
    end

    def update
      if current_employer.update(settings_params)
        redirect_to employer_settings_path, notice: "Settings updated."
      else
        render :show, status: :unprocessable_entity
      end
    end

    private

    def settings_params
      params.require(:employer_profile).permit(:company_name, :company_domain, :company_size, :industry, :company_description, :company_logo_url)
    end
  end
end
