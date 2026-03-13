module Api
  module V1
    class SalaryIntelligenceController < BaseController
      def show
        role = params[:role]
        city = params[:city]
        experience = params[:experience].to_i

        unless role.present? && city.present? && experience > 0
          return render json: { error: "Required params: role, city, experience" }, status: :bad_request
        end

        track_usage!

        submissions = SalarySubmission.where(role: role)
        submissions = submissions.where("LOWER(city) = ?", city.downcase) if city.present?

        if submissions.exists?
          salaries = submissions.pluck(:salary)
          render json: {
            role: role,
            city: city,
            experience_years: experience,
            data: {
              median: median(salaries),
              average: (salaries.sum / salaries.size.to_f).round,
              min: salaries.min,
              max: salaries.max,
              percentile_25: percentile(salaries, 25),
              percentile_75: percentile(salaries, 75),
              sample_size: salaries.size
            },
            timestamp: Time.current.iso8601
          }
        else
          render json: {
            role: role,
            city: city,
            experience_years: experience,
            data: nil,
            message: "No salary data available for this combination. Contribute data to improve results.",
            timestamp: Time.current.iso8601
          }
        end
      end

      private

      def median(arr)
        sorted = arr.sort
        mid = sorted.size / 2
        sorted.size.odd? ? sorted[mid] : ((sorted[mid - 1] + sorted[mid]) / 2.0).round
      end

      def percentile(arr, pct)
        sorted = arr.sort
        idx = (pct / 100.0 * (sorted.size - 1)).round
        sorted[idx]
      end
    end
  end
end
