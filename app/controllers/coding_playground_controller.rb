class CodingPlaygroundController < ApplicationController
  before_action :authenticate_user!

  def index
    @service = CodingPlaygroundService.new(current_user)
    @problems = @service.problems(difficulty: params[:difficulty])
    @recent = @service.recent_submissions(5)
  end

  def show
    @service = CodingPlaygroundService.new(current_user)
    @problem = @service.find_problem(params[:id])
    redirect_to coding_playground_index_path, alert: "Problem not found." unless @problem
  end

  def submit
    service = CodingPlaygroundService.new(current_user)
    @submission = service.evaluate(params[:problem_id], params[:code], params[:language] || "python")

    if @submission&.completed?
      redirect_to coding_playground_result_path(@submission), notice: "Code evaluated!"
    else
      redirect_to coding_playground_path(params[:problem_id]), alert: "Evaluation failed. Please try again."
    end
  end

  def result
    @submission = current_user.code_submissions.find(params[:id])
    @problem = @submission.problem_data
  end
end
