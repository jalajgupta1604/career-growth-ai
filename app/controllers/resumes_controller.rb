class ResumesController < ApplicationController
  before_action :authenticate_user!

  def new
    @resume = current_user.resumes.new
  end

  def create
    @resume = current_user.resumes.new
    @resume.file.attach(params[:resume][:file]) if params[:resume][:file].present?

    if @resume.save
      ResumeParsingJob.perform_later(@resume.id)
      redirect_to dashboard_path, notice: "Resume uploaded! Parsing in progress..."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @resume = current_user.resumes.find(params[:id])
  end
end
