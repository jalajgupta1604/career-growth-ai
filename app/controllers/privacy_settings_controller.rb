class PrivacySettingsController < ApplicationController
  before_action :authenticate_user!

  def show
    @settings = current_user.privacy_settings || {}
  end

  def update
    settings = {
      "salary_visibility" => params.dig(:privacy, :salary_visibility) || "private",
      "profile_visibility" => params.dig(:privacy, :profile_visibility) || "connections",
      "activity_visibility" => params.dig(:privacy, :activity_visibility) || "private",
      "show_in_search" => params.dig(:privacy, :show_in_search) == "1"
    }

    current_user.update!(privacy_settings: settings)
    redirect_to privacy_settings_path, notice: "Privacy settings updated."
  end
end
