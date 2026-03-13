module Api
  module V1
    class SkillDemandController < BaseController
      def index
        track_usage!

        trends = SkillTrend.order(demand_score: :desc).limit(params[:limit]&.to_i || 20)

        if params[:role].present?
          trends = trends.where("LOWER(role) = ?", params[:role].downcase)
        end

        render json: {
          skills: trends.map { |t|
            {
              name: t.skill_name,
              role: t.role,
              demand_score: t.demand_score,
              trend: t.trend_direction,
              growth_rate: t.growth_rate,
              avg_salary_premium: t.salary_premium
            }
          },
          total: trends.size,
          timestamp: Time.current.iso8601
        }
      end
    end
  end
end
