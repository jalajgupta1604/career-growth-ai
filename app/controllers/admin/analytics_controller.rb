module Admin
  class AnalyticsController < BaseController
    def index
      @stats = AnalyticsService.dashboard_stats
      @revenue_forecast = AnalyticsService.revenue_forecast(months_ahead: 6)
    end
  end
end
