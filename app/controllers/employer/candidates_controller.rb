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
      @revealed_ids = current_employer.candidate_reveals.where(user_id: @candidates.map(&:id)).pluck(:user_id)
      render :results
    end

    def reveal
      user = User.find(params[:id])
      current_employer.reveal!(user)
      redirect_back fallback_location: employer_candidates_path, notice: "Candidate revealed. #{current_employer.candidate_reveal_credits} credits remaining."
    rescue => e
      redirect_back fallback_location: employer_candidates_path, alert: e.message
    end

    private

    def search_filters
      params.permit(:role, :city, :experience_min, :experience_max).to_h
    end
  end
end
