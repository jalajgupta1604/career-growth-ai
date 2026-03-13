class ResumeBuilderController < ApplicationController
  before_action :authenticate_user!

  def index
    @resumes = current_user.generated_resumes.recent.limit(20)
  end

  def new
  end

  def create
    service = ResumeBuilderService.new(current_user)
    @resume = service.generate(params[:target_role])
    if @resume.completed?
      redirect_to resume_builder_path(@resume), notice: "Resume generated!"
    else
      redirect_to resume_builder_index_path, alert: "Generation failed. Please try again."
    end
  end

  def show
    @resume = current_user.generated_resumes.find(params[:id])
  end
end
