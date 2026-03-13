module Employer
  class JobsController < BaseController
    def index
      @jobs = current_employer.job_postings.order(created_at: :desc).page(params[:page]).per(10)
    end

    def new
      @job = current_employer.job_postings.build
    end

    def create
      @job = current_employer.job_postings.build(job_params)
      @job.posted_by = current_user

      if @job.save
        redirect_to employer_jobs_path, notice: "Job posted successfully."
      else
        render :new, status: :unprocessable_entity
      end
    end

    def edit
      @job = current_employer.job_postings.find(params[:id])
    end

    def update
      @job = current_employer.job_postings.find(params[:id])
      if @job.update(job_params)
        redirect_to employer_jobs_path, notice: "Job updated."
      else
        render :edit, status: :unprocessable_entity
      end
    end

    private

    def job_params
      params.require(:job_posting).permit(:title, :company_name, :location, :job_type, :experience_level, :salary_range, :description, :requirements, :application_email, :application_url, :expires_at)
    end
  end
end
