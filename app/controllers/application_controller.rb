class ApplicationController < ActionController::Base
  allow_browser versions: :modern

  private

  def after_sign_in_path_for(resource)
    if resource.onboarding_complete?
      dashboard_path
    else
      onboarding_path
    end
  end
end
