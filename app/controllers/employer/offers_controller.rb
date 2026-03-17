module Employer
  class OffersController < BaseController
    def index
      service = OfferManagementService.new(current_employer)
      @offers = service.offers_for_employer.page(params[:page]).per(20)
      @stats = service.stats
    end

    def new
      @application = JobApplication.find(params[:application_id])
      @offer = JobOffer.new
    end

    def create
      @application = JobApplication.find(params[:job_offer][:job_application_id])
      service = OfferManagementService.new(current_employer)

      @offer = service.create_offer(
        job_application: @application,
        params: offer_params
      )

      redirect_to employer_offer_path(@offer), notice: "Offer draft created."
    rescue ActiveRecord::RecordInvalid => e
      redirect_to employer_offers_path, alert: e.message
    end

    def show
      @offer = JobOffer.find(params[:id])
    end

    def send_offer
      offer = JobOffer.find(params[:id])
      service = OfferManagementService.new(current_employer)
      service.send_offer(offer)
      redirect_to employer_offer_path(offer), notice: "Offer sent to candidate."
    end

    def withdraw
      offer = JobOffer.find(params[:id])
      offer.update!(status: "withdrawn")
      redirect_to employer_offers_path, notice: "Offer withdrawn."
    end

    private

    def offer_params
      params.require(:job_offer).permit(
        :base_salary, :variable_pay, :equity_value, :designation,
        :location, :joining_date, :benefits, :additional_terms
      )
    end
  end
end
