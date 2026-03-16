module Employer
  class AnalyticsController < BaseController
    def index
      @employer = current_employer
      applications = JobApplication.joins(:job_posting)
                                   .where(job_postings: { employer_profile_id: @employer.id })

      @total_applications = applications.count
      @total_hires = applications.where(status: "hired").count
      @active_jobs = @employer.job_postings.active.count

      @pipeline_stats = applications.group(:status).count

      @time_to_hire = calculate_time_to_hire(applications)
      @source_quality = calculate_stage_conversion(applications)
      @recent_activity = applications.includes(:user, :job_posting)
                                     .order(updated_at: :desc)
                                     .limit(10)
    end

    private

    def calculate_time_to_hire(applications)
      hired = applications.where(status: "hired")
                          .where.not(updated_at: nil)
      return 0 if hired.empty?

      total_days = hired.sum { |a| (a.updated_at.to_date - a.created_at.to_date).to_i }
      (total_days.to_f / hired.count).round(1)
    end

    def calculate_stage_conversion(applications)
      total = applications.count.to_f
      return {} if total.zero?

      {
        "Applied" => 100,
        "Shortlisted" => (applications.where(status: %w[shortlisted interviewing offered hired]).count / total * 100).round(1),
        "Interviewing" => (applications.where(status: %w[interviewing offered hired]).count / total * 100).round(1),
        "Offered" => (applications.where(status: %w[offered hired]).count / total * 100).round(1),
        "Hired" => (applications.where(status: "hired").count / total * 100).round(1)
      }
    end
  end
end
