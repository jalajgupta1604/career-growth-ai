class EnterpriseController < ApplicationController
  before_action :authenticate_user!
  before_action :set_company
  before_action :require_admin!, only: [:manage_members, :add_member, :remove_member]

  def dashboard
    service = EnterpriseAnalyticsService.new(@company)
    @data = service.dashboard_data
  end

  def refresh
    service = EnterpriseAnalyticsService.new(@company)
    service.generate_snapshot
    redirect_to enterprise_dashboard_path, notice: "Analytics snapshot refreshed!"
  rescue => e
    Rails.logger.error("Enterprise refresh failed: #{e.message}")
    redirect_to enterprise_dashboard_path, alert: "Failed to refresh analytics."
  end

  def manage_members
    @members = @company.company_members.includes(:user).order(created_at: :desc)
  end

  def add_member
    user = User.find_by(email: params[:email])
    unless user
      redirect_to enterprise_members_path, alert: "No user found with that email."
      return
    end

    @company.company_members.find_or_create_by!(user: user) do |m|
      m.role = params[:member_role] || "member"
    end
    redirect_to enterprise_members_path, notice: "#{user.email} added to the team."
  rescue => e
    redirect_to enterprise_members_path, alert: "Failed to add member: #{e.message}"
  end

  def remove_member
    member = @company.company_members.find(params[:member_id])
    member.destroy!
    redirect_to enterprise_members_path, notice: "Member removed."
  end

  private

  def set_company
    @company = current_user.companies.first
    unless @company
      redirect_to dashboard_path, alert: "You are not part of any enterprise team."
    end
  end

  def require_admin!
    member = @company.company_members.find_by(user: current_user)
    unless member&.admin?
      redirect_to enterprise_dashboard_path, alert: "Only admins can manage team members."
    end
  end
end
