class ContentRecommendationService
  def initialize(user)
    @user = user
  end

  def recommendations(limit: 5)
    recs = []
    recs.concat(role_based_lessons)
    recs.concat(skill_gap_packs)
    recs.concat(popular_with_peers)
    recs.uniq { |r| [r[:type], r[:id]] }.first(limit)
  end

  private

  def role_based_lessons
    return [] unless @user.role.present?

    completed_ids = @user.lesson_progresses.where(completed: true).pluck(:prep_lesson_id)

    PrepLesson.joins(:prep_category)
              .where.not(id: completed_ids)
              .where("prep_categories.name ILIKE ? OR prep_lessons.title ILIKE ?", "%#{@user.role}%", "%#{@user.role}%")
              .limit(3)
              .map { |l| { type: "lesson", id: l.id, title: l.title, reason: "Recommended for #{@user.role}", url: "/interview-prep/lessons/#{l.id}" } }
  end

  def skill_gap_packs
    return [] unless @user.career_reports.exists?

    report = @user.career_reports.order(created_at: :desc).first
    gaps = report.skill_gaps rescue nil
    return [] unless gaps.is_a?(Array) && gaps.any?

    CompanyPack.where("name ILIKE ANY(ARRAY[?])", gaps.first(3).map { |g| "%#{g}%" })
               .limit(2)
               .map { |p| { type: "company_pack", id: p.id, title: p.name, reason: "Covers your skill gap", url: "/company-packs/#{p.slug}" } }
  rescue
    []
  end

  def popular_with_peers
    return [] unless @user.role.present? && @user.experience_years.present?

    peer_ids = User.where(role: @user.role)
                   .where(experience_years: (@user.experience_years - 2)..(@user.experience_years + 2))
                   .where.not(id: @user.id)
                   .limit(100)
                   .pluck(:id)
    return [] if peer_ids.empty?

    popular_lesson_ids = LessonProgress.where(user_id: peer_ids, completed: true)
                                        .group(:prep_lesson_id)
                                        .order("count_id DESC")
                                        .limit(3)
                                        .count(:id)
                                        .keys

    completed_ids = @user.lesson_progresses.where(completed: true).pluck(:prep_lesson_id)
    remaining = popular_lesson_ids - completed_ids
    return [] if remaining.empty?

    PrepLesson.where(id: remaining).limit(2).map do |l|
      { type: "lesson", id: l.id, title: l.title, reason: "Popular with #{@user.role}s at your level", url: "/interview-prep/lessons/#{l.id}" }
    end
  end
end
