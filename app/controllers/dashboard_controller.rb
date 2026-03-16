class DashboardController < ApplicationController
  before_action :authenticate_user!

  def show
    redirect_to onboarding_path unless current_user.onboarding_complete?

    @resume = current_user.resumes.order(created_at: :desc).first
    @all_resumes = current_user.resumes.order(created_at: :desc)
    @latest_report = current_user.career_reports.order(created_at: :desc).first
    @all_reports = current_user.career_reports.order(created_at: :desc)
    @salary_analysis = SalaryBenchmarkService.new(current_user).analyze
    @nudges = SmartNudgeService.new(current_user).generate_nudges
    @recommendations = ContentRecommendationService.new(current_user).recommendations(limit: 3)
  end
end
