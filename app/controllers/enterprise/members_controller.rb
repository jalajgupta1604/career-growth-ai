module Enterprise
  class MembersController < BaseController
    before_action :require_hr_admin!, except: [:index]

    def index
      @members = @company.company_members.includes(:user, :department).order(created_at: :desc)
    end

    def create
      user = User.find_by(email: params[:email])
      unless user
        redirect_to enterprise_members_path, alert: "No user found with that email."
        return
      end

      @company.company_members.find_or_create_by!(user: user) do |m|
        m.role = params[:member_role] || "employee"
      end
      redirect_to enterprise_members_path, notice: "#{user.email} added to the team."
    rescue => e
      redirect_to enterprise_members_path, alert: "Failed to add member: #{e.message}"
    end

    def destroy
      member = @company.company_members.find(params[:id])
      member.destroy!
      redirect_to enterprise_members_path, notice: "Member removed."
    end
  end
end
