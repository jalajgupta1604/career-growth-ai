module Employer
  class LandingController < ApplicationController
    layout "employer_public"

    def index
      redirect_to employer_root_path if user_signed_in? && current_user.employer_profile.present?
    end
  end
end
