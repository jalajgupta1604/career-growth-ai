class InterviewExperienceService
  def initialize(user = nil)
    @user = user
  end

  def submit(params)
    @user.interview_experiences.create!(
      company_name: params[:company_name],
      role: params[:role] || @user.role,
      difficulty: params[:difficulty] || "medium",
      outcome: params[:outcome],
      rounds_count: params[:rounds_count],
      overall_rating: params[:overall_rating],
      experience_summary: params[:experience_summary],
      rounds_data: parse_rounds(params[:rounds_data]),
      tags: parse_tags(params[:tags]),
      anonymous: params[:anonymous] != "false"
    )
  end

  def explore(filters = {})
    scope = InterviewExperience.all

    scope = scope.for_company(filters[:company_name]) if filters[:company_name].present?
    scope = scope.for_role(filters[:role]) if filters[:role].present?
    scope = scope.where(difficulty: filters[:difficulty]) if filters[:difficulty].present?
    scope = scope.where(outcome: filters[:outcome]) if filters[:outcome].present?

    experiences = scope.recent.limit(50)

    {
      experiences: experiences,
      stats: calculate_stats(scope),
      company_clusters: company_clusters(filters[:role]),
      total_count: scope.count
    }
  end

  def company_clusters(role = nil)
    scope = InterviewExperience.all
    scope = scope.for_role(role) if role.present?

    scope.group(:company_name)
         .having("COUNT(*) >= 1")
         .select(
           "company_name",
           "COUNT(*) as total_count",
           "ROUND(AVG(overall_rating)::numeric, 1) as avg_rating",
           "ROUND(AVG(rounds_count)::numeric, 1) as avg_rounds",
           "SUM(CASE WHEN outcome = 'selected' THEN 1 ELSE 0 END) as selected_count",
           "MODE() WITHIN GROUP (ORDER BY difficulty) as common_difficulty"
         )
         .order("total_count DESC")
         .limit(20)
  end

  private

  def calculate_stats(scope)
    {
      total: scope.count,
      avg_rating: scope.where.not(overall_rating: nil).average(:overall_rating)&.round(1) || 0,
      avg_rounds: scope.where.not(rounds_count: nil).average(:rounds_count)&.round(1) || 0,
      selection_rate: selection_rate(scope),
      difficulty_breakdown: {
        easy: scope.where(difficulty: "easy").count,
        medium: scope.where(difficulty: "medium").count,
        hard: scope.where(difficulty: "hard").count
      },
      outcome_breakdown: {
        selected: scope.where(outcome: "selected").count,
        rejected: scope.where(outcome: "rejected").count,
        in_progress: scope.where(outcome: "in_progress").count,
        no_response: scope.where(outcome: "no_response").count
      }
    }
  end

  def selection_rate(scope)
    total = scope.where(outcome: ["selected", "rejected"]).count
    return 0 if total.zero?
    selected = scope.where(outcome: "selected").count
    (selected.to_f / total * 100).round(1)
  end

  def parse_rounds(data)
    return [] if data.blank?
    return data if data.is_a?(Array)
    data.to_s.split("\n").map(&:strip).reject(&:empty?).each_with_index.map do |desc, idx|
      { round: idx + 1, description: desc }
    end
  end

  def parse_tags(tags)
    return [] if tags.blank?
    return tags if tags.is_a?(Array)
    tags.to_s.split(",").map(&:strip).reject(&:empty?)
  end
end
