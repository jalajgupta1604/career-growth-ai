class InterviewDebriefService
  def initialize(user)
    @user = user
  end

  def create_debrief(params)
    debrief = @user.interview_debriefs.create!(
      company_name: params[:company_name],
      role_applied: params[:role_applied],
      interview_date: params[:interview_date],
      questions_data: parse_questions(params[:questions_text]),
      user_notes: params[:user_notes],
      status: :pending
    )

    analyze_debrief(debrief)
    debrief
  end

  def recent_debriefs(limit = 10)
    @user.interview_debriefs.recent.limit(limit)
  end

  private

  def parse_questions(questions_text)
    return [] if questions_text.blank?

    questions_text.split("\n").map(&:strip).reject(&:blank?).map.with_index do |q, i|
      { "index" => i + 1, "question" => q }
    end
  end

  def analyze_debrief(debrief)
    debrief.update!(status: :analyzing)

    questions = (debrief.questions_data || []).map { |q| q["question"] }.join("\n- ")
    prompt = GeminiPrompts.interview_debrief_prompt(
      debrief.company_name,
      debrief.role_applied || @user.role || "Software Developer",
      questions,
      debrief.user_notes
    )

    result = GeminiClient.new.generate(prompt, response_schema: debrief_schema)

    if result
      debrief.update!(ai_analysis: result, status: :completed)
    else
      debrief.update!(status: :failed)
    end
  rescue => e
    Rails.logger.error("Interview debrief analysis failed: #{e.message}")
    debrief.update!(status: :failed)
  end

  def debrief_schema
    {
      type: "OBJECT",
      properties: {
        overall_assessment: { type: "STRING" },
        difficulty_rating: { type: "STRING" },
        question_analysis: {
          type: "ARRAY",
          items: {
            type: "OBJECT",
            properties: {
              question: { type: "STRING" },
              category: { type: "STRING" },
              difficulty: { type: "STRING" },
              model_answer: { type: "STRING" },
              tips: { type: "STRING" }
            }
          }
        },
        strengths_detected: { type: "ARRAY", items: { type: "STRING" } },
        areas_to_improve: { type: "ARRAY", items: { type: "STRING" } },
        prep_recommendations: { type: "ARRAY", items: { type: "STRING" } },
        company_insights: { type: "STRING" }
      }
    }
  end
end
