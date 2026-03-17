class ReferralHiringService
  def initialize(employer_profile)
    @employer = employer_profile
  end

  def create_referral(referrer:, candidate:, job_posting:)
    HiringReferral.create!(
      referrer: referrer,
      candidate: candidate,
      job_posting: job_posting,
      employer_profile: @employer,
      status: "referred"
    )
  end

  def update_status(referral, new_status)
    referral.update!(status: new_status)

    if new_status == "hired"
      referral.mark_hired!
      NotificationService.notify(
        user: referral.referrer,
        title: "Referral hired!",
        body: "Your referral for #{referral.job_posting.title} has been hired. Commission pending.",
        category: "career"
      )
    end
  end

  def referrals_for_employer
    HiringReferral.where(employer_profile: @employer).recent.includes(:referrer, :candidate, :job_posting)
  end

  def referrals_by_user(user)
    HiringReferral.where(referrer: user).recent.includes(:candidate, :job_posting)
  end

  def pending_commissions
    HiringReferral.where(employer_profile: @employer).pending_commission
  end

  def stats
    referrals = HiringReferral.where(employer_profile: @employer)
    {
      total_referrals: referrals.count,
      hired: referrals.where(status: "hired").count,
      conversion_rate: referrals.count > 0 ?
        (referrals.where(status: "hired").count.to_f / referrals.count * 100).round(1) : 0,
      total_commission_paid: referrals.where(commission_status: "paid").sum(:commission_amount),
      pending_commission: referrals.pending_commission.sum(:commission_amount)
    }
  end
end
