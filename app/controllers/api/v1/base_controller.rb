module Api
  module V1
    class BaseController < ActionController::API
      before_action :authenticate_api_key!
      before_action :check_rate_limit!

      private

      def authenticate_api_key!
        key = request.headers["Authorization"]&.gsub("Bearer ", "")
        @api_key = ApiKey.active.find_by(key: key)

        unless @api_key
          render json: { error: "Invalid or missing API key" }, status: :unauthorized
        end
      end

      def check_rate_limit!
        return unless @api_key

        unless @api_key.within_rate_limit?
          render json: { error: "Rate limit exceeded. Upgrade your plan for higher limits.", limit: @api_key.rate_limit, used: @api_key.calls_count }, status: :too_many_requests
        end
      end

      def track_usage!
        @api_key&.increment_usage!
      end
    end
  end
end
