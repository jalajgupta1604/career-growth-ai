module Enterprise
  class DashboardController < BaseController
    def show
      service = EnterpriseAnalyticsService.new(@company)
      @data = service.dashboard_data
    end

    def refresh
      service = EnterpriseAnalyticsService.new(@company)
      service.generate_snapshot
      redirect_to enterprise_root_path, notice: "Analytics snapshot refreshed!"
    rescue => e
      Rails.logger.error("Enterprise refresh failed: #{e.message}")
      redirect_to enterprise_root_path, alert: "Failed to refresh analytics."
    end
  end
end
