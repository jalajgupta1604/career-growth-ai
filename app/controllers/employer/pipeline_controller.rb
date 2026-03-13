module Employer
  class PipelineController < BaseController
    def index
      @job = current_employer.job_postings.find(params[:job_id])
      @applications = @job.job_applications.includes(:user).order(created_at: :desc)
      @stages = %w[applied screening interview offer hired rejected]
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
