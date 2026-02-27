class OnboardingController < ApplicationController
  before_action :authenticate_user!

  VALID_ROLES = [
    "Software Developer", "Frontend Developer", "Backend Developer",
    "Full Stack Developer", "QA Engineer", "Data Analyst",
    "Data Scientist", "DevOps Engineer", "Product Manager"
  ].freeze

  VALID_CITIES = [
    "Bangalore", "Mumbai", "Delhi", "Hyderabad", "Pune", "Chennai",
    "Kolkata", "Noida", "Gurugram", "Ahmedabad"
  ].freeze

  def show
    redirect_to dashboard_path if current_user.onboarding_complete?
  end

  def update
    if current_user.update(onboarding_params)
      redirect_to new_resume_path, notice: "Profile updated! Now upload your resume."
    else
      render :show, status: :unprocessable_entity
    end
  end

  private

  def onboarding_params
    params.require(:user).permit(:role, :city, :experience_years, :current_salary)
  end
end
