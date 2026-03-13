module Employer
  class CandidatesController < BaseController
    def index
      @searches = current_employer.candidate_searches.order(created_at: :desc).limit(10)
    end

    def search
      @search = current_employer.candidate_searches.create!(
        name: params[:name] || "Search #{Time.current.strftime('%b %d %H:%M')}",
        filters: search_filters
      )
      @candidates = @search.execute
      render :results
    end

    private

    def search_filters
      params.permit(:role, :city, :experience_min, :experience_max).to_h
    end
  end
end
