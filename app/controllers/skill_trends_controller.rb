class SkillTrendsController < ApplicationController
  before_action :authenticate_user!

  def index
    role = params[:role] || current_user.role
    service = SkillTrendService.new(role: role)
    @data = service.dashboard_data
    @selected_role = role
  end

  def show
    role = params[:role] || current_user.role
    service = SkillTrendService.new(role: role)
    @detail = service.skill_detail(params[:id])

    unless @detail
      redirect_to skill_trends_path, alert: "Skill trend data not found."
    end
  end

  def seed
    service = SkillTrendService.new
    service.seed_trends_from_skills
    redirect_to skill_trends_path, notice: "Skill trends seeded from current data."
  end
end
