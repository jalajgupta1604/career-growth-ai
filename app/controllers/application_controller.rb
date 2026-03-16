class ApplicationController < ActionController::Base
  allow_browser versions: :modern

  private

  def after_sign_in_path_for(resource)
    intent = session.delete(:login_intent)

    if intent == "employer"
      if resource.employer_profile.present?
        employer_root_path
      else
        employer_onboarding_path
      end
    elsif resource.onboarding_complete?
      dashboard_path
    else
      onboarding_path
    end
  end
end
