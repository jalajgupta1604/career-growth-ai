module Employer
  class ReferralsController < BaseController
    def index
      service = ReferralHiringService.new(current_employer)
      @referrals = service.referrals_for_employer.page(params[:page]).per(20)
      @stats = service.stats
      @pending_commissions = service.pending_commissions
    end

    def update_status
      referral = HiringReferral.find(params[:id])
      service = ReferralHiringService.new(current_employer)
      service.update_status(referral, params[:status])
      redirect_to employer_referrals_path, notice: "Referral status updated to #{params[:status]}."
    end

    def pay_commission
      referral = HiringReferral.find(params[:id])
      referral.pay_commission!
      redirect_to employer_referrals_path, notice: "Commission marked as paid."
    end
  end
end
