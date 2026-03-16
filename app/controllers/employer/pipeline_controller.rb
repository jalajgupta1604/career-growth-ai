module Employer
  class PipelineController < BaseController
    def index
      @stages = %w[applied screening interview offer hired rejected]
      @jobs = current_employer.job_postings.order(created_at: :desc)

      if params[:job_id].present?
        @job = current_employer.job_postings.find(params[:job_id])
        @applications = @job.job_applications.includes(:user, :job_posting).order(created_at: :desc)
      else
        @applications = JobApplication.joins(:job_posting)
                                      .where(job_postings: { employer_profile_id: current_employer.id })
                                      .includes(:user, :job_posting)
                                      .order(created_at: :desc)
      end
    end

    def update_stage
      @application = JobApplication.joins(:job_posting)
                                   .where(job_postings: { employer_profile_id: current_employer.id })
                                   .find(params[:id])
      @application.update!(pipeline_stage: params[:stage], employer_notes: params[:notes])
      redirect_back fallback_location: employer_pipeline_index_path(job_id: @application.job_posting_id), notice: "Stage updated."
    end
  end
end
