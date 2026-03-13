module Api
  module V1
    class ResumeParsingController < BaseController
      def create
        unless params[:resume_text].present?
          return render json: { error: "Required param: resume_text" }, status: :bad_request
        end

        track_usage!

        role = params[:target_role] || "Software Developer"
        prompt = GeminiPrompts.resume_analysis_prompt(params[:resume_text], role)
        result = GeminiClient.new.generate(prompt, response_schema: resume_schema)

        if result
          render json: {
            parsed: result,
            target_role: role,
            timestamp: Time.current.iso8601
          }
        else
          render json: { error: "Failed to parse resume. Please try again." }, status: :service_unavailable
        end
      end

      private

      def resume_schema
        {
          type: "OBJECT",
          properties: {
            skills: { type: "ARRAY", items: { type: "STRING" } },
            projects: { type: "ARRAY", items: { type: "OBJECT", properties: { name: { type: "STRING" }, description: { type: "STRING" }, technologies: { type: "STRING" } } } },
            certifications: { type: "ARRAY", items: { type: "STRING" } },
            experience_entries: { type: "ARRAY", items: { type: "OBJECT", properties: { title: { type: "STRING" }, company: { type: "STRING" }, duration: { type: "STRING" }, highlights: { type: "ARRAY", items: { type: "STRING" } } } } },
            summary: { type: "STRING" }
          }
        }
      end
    end
  end
end
