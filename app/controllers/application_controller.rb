class ApplicationController < ActionController::Base
  allow_browser versions: :modern
  helper_method :impersonating?, :ab_variant

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

  def impersonating?
    session[:admin_id].present?
  end

  def ab_variant(experiment_name)
    return nil unless current_user
    AbTestingService.new(current_user).variant_for(experiment_name)
  end
end
