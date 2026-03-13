class JobPostingsController < ApplicationController
  before_action :authenticate_user!

  def index
    @postings = JobPosting.active_listings.limit(50)
    @my_applications = current_user.job_applications.includes(:job_posting).recent
  end

  def show
    @posting = JobPosting.find(params[:id])
    @applied = current_user.job_applications.exists?(job_posting: @posting)
  end

  def new
    @posting = JobPosting.new
  end

  def create
    @posting = current_user.job_postings.build(posting_params)
    @posting.status = :active
    if @posting.save
      redirect_to job_posting_path(@posting), notice: "Job posted!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def apply
    posting = JobPosting.find(params[:id])
    application = current_user.job_applications.build(job_posting: posting, status: :applied, applied_at: Time.current)
    if application.save
      redirect_to job_posting_path(posting), notice: "Application submitted!"
    else
      redirect_to job_posting_path(posting), alert: application.errors.full_messages.join(", ")
    end
  end

  private

  def posting_params
    params.require(:job_posting).permit(:company_name, :title, :description, :location, :job_type, :min_salary, :max_salary, :experience_range, required_skills: [])
  end
end
