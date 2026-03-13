module Employer
  class DashboardController < BaseController
    def show
      @active_jobs = current_employer.job_postings.where("expires_at IS NULL OR expires_at > ?", Time.current).count
      @total_applications = JobApplication.joins(:job_posting).where(job_postings: { employer_profile_id: current_employer.id }).count
      @recent_applications = JobApplication.joins(:job_posting)
                                           .where(job_postings: { employer_profile_id: current_employer.id })
                                           .order(created_at: :desc)
                                           .includes(:user, :job_posting)
                                           .limit(10)
      @pipeline_stats = JobApplication.joins(:job_posting)
                                      .where(job_postings: { employer_profile_id: current_employer.id })
                                      .group(:pipeline_stage)
                                      .count
    end
  end
end
