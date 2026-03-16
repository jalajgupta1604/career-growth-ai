class CompaniesController < ApplicationController
  def show
    @company = EmployerProfile.verified.find_by!(slug: params[:slug])
    @jobs = @company.job_postings.active_listings.limit(20)
  end
end
