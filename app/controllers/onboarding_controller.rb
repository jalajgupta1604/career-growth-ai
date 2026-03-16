class OnboardingController < ApplicationController
  before_action :authenticate_user!

  VALID_ROLES = [
    "Software Developer", "Frontend Developer", "Backend Developer",
    "Full Stack Developer", "QA Engineer", "Data Analyst",
    "Data Scientist", "DevOps Engineer", "Product Manager"
  ].freeze

  VALID_CITIES = [
    "Bangalore", "Mumbai", "Delhi", "Hyderabad", "Pune", "Chennai",
    "Kolkata", "Noida", "Gurugram", "Ahmedabad", "Indore", "Bhopal",
    "Jaipur", "Chandigarh"
  ].freeze

  ONBOARDING_PATHS = {
    "job_seeker" => { label: "Find a New Job", icon: "work", features: %w[resume_builder job_recommendations interview_prep] },
    "career_growth" => { label: "Grow in My Role", icon: "trending_up", features: %w[skill_trends salary_insights career_reports] },
    "interview_prep" => { label: "Ace Interviews", icon: "record_voice_over", features: %w[mock_interviews daily_challenges company_packs] },
    "salary_negotiation" => { label: "Negotiate Better", icon: "payments", features: %w[salary_benchmarks negotiation_tools offer_analysis] }
  }.freeze

  def show
    redirect_to dashboard_path if current_user.onboarding_complete?
    @resume = current_user.resumes.new
  end

  def update
    if current_user.update(onboarding_params)
      # Handle resume upload if present
      if params[:resume_file].present?
        resume = current_user.resumes.new
        resume.file.attach(params[:resume_file])
        resume.save!
        ResumeParsingJob.perform_later(resume.id)
      end
      redirect_to dashboard_path, notice: "Profile complete! Your career analysis is ready."
    else
      @resume = current_user.resumes.new
      render :show, status: :unprocessable_entity
    end
  end

  private

  def onboarding_params
    params.require(:user).permit(:role, :city, :experience_years, :current_salary, :onboarding_path, career_goals: [])
  end
end
