class OfferManagementService
  def initialize(employer_profile)
    @employer = employer_profile
  end

  def create_offer(job_application:, params:)
    JobOffer.create!(
      job_application: job_application,
      employer_profile: @employer,
      candidate: job_application.user,
      base_salary: params[:base_salary],
      variable_pay: params[:variable_pay],
      equity_value: params[:equity_value],
      designation: params[:designation],
      location: params[:location],
      joining_date: params[:joining_date],
      benefits: params[:benefits],
      additional_terms: params[:additional_terms],
      status: "draft"
    )
  end

  def send_offer(offer)
    offer.send_to_candidate!
  end

  def offers_for_employer
    JobOffer.where(employer_profile: @employer).recent
  end

  def offers_for_candidate(user)
    JobOffer.where(candidate: user).recent
  end

  def stats
    offers = JobOffer.where(employer_profile: @employer)
    {
      total: offers.count,
      sent: offers.where(status: "sent").count,
      accepted: offers.where(status: "accepted").count,
      declined: offers.where(status: "declined").count,
      acceptance_rate: offers.where(status: %w[accepted declined]).count > 0 ?
        (offers.where(status: "accepted").count.to_f / offers.where(status: %w[accepted declined]).count * 100).round(1) : 0
    }
  end
end
