module Admin
  class DashboardController < BaseController
    def show
      @total_users = User.count
      @new_users_today = User.where("created_at >= ?", Time.current.beginning_of_day).count
      @new_users_week = User.where("created_at >= ?", 7.days.ago).count
      @active_subscribers = Subscription.where(status: :active).count
      @monthly_revenue = Subscription.where(status: :active).sum(:amount) / 100.0
      @pending_flags = ContentFlag.unresolved.count
      @recent_audit_logs = AuditLog.recent.includes(:user).limit(20)
      @user_growth = User.where("created_at >= ?", 30.days.ago)
                         .group_by_day(:created_at)
                         .count
    rescue => e
      @user_growth = {}
    end

    private

    def group_by_day(scope)
      scope.group("DATE(created_at)").count
    end
  end
end
