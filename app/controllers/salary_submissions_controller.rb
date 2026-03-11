class SalarySubmissionsController < ApplicationController
  before_action :authenticate_user!

  def index
    service = SalaryCrowdsourceService.new(current_user)
    @data = service.explore(filter_params)
    @available_roles = service.available_roles
    @available_cities = service.available_cities
    @filters = filter_params
  end

  def new
  end

  def create
    service = SalaryCrowdsourceService.new(current_user)
    service.submit(submission_params)
    redirect_to salary_submissions_path, notice: "Salary data submitted! Thank you for contributing."
  rescue => e
    Rails.logger.error("Salary submission failed: #{e.message}")
    redirect_to new_salary_submission_path, alert: "Failed to submit salary data. Please check your inputs."
  end

  private

  def submission_params
    params.require(:salary_submission).permit(:role, :city, :experience_years, :base_salary, :total_ctc, :company_name, :company_type, :components, :anonymous)
  end

  def filter_params
    params.permit(:role, :city, :experience_years, :company_type)
  end
end
