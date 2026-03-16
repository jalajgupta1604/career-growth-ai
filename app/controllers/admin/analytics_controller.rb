module Admin
  class AnalyticsController < BaseController
    def index
      @stats = AnalyticsService.dashboard_stats
      @revenue_forecast = AnalyticsService.revenue_forecast(months_ahead: 6)
      @popular_searches = SearchQuery.popular
      @zero_result_searches = SearchQuery.top_zero_result_queries(10)
      @trending = TrendingContentService.trending(limit: 5)

      respond_to do |format|
        format.html
        format.csv { send_data generate_csv, filename: "analytics-#{Date.current}.csv" }
      end
    end

    private

    def generate_csv
      require "csv"
      CSV.generate(headers: true) do |csv|
        csv << ["Metric", "Value"]
        @stats.each do |key, value|
          next if value.is_a?(Array) || value.is_a?(Hash)
          csv << [key.to_s.humanize, value]
        end
        csv << []
        csv << ["Revenue Forecast"]
        csv << ["Month", "Projected MRR"]
        @revenue_forecast.each do |f|
          csv << [f[:month], f[:projected_mrr]]
        end
      end
    end
  end
end
