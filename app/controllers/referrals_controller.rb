class ReferralsController < ApplicationController
  before_action :authenticate_user!

  def show
    service = ReferralService.new(current_user)
    @data = service.dashboard_data
  end

  def apply
    service = ReferralService.new(current_user)
    result = service.apply_referral_code(params[:referral_code])

    if result[:success]
      redirect_to referral_path, notice: result[:message]
    else
      redirect_to referral_path, alert: result[:error]
    end
  end
end
