class InterviewPrepService
  def initialize(user)
    @user = user
  end

  def dashboard_data
    categories = PrepCategory.ordered.includes(:prep_lessons)

    {
      categories_with_progress: categories.map { |cat| category_data(cat) },
      overall_progress: overall_progress(categories),
      next_lesson: find_next_lesson(categories),
      last_session_lesson: find_last_session_lesson,
      weekly_summary: weekly_summary,
      expert_tip: expert_tip,
      resources: resources
    }
  end

  def mark_lesson_started(lesson)
    progress = LessonProgress.find_or_initialize_by(user: @user, prep_lesson: lesson)
    return progress if progress.completed?

    progress.update!(status: :in_progress, started_at: Time.current)
    progress
  end

  def mark_lesson_completed(lesson)
    progress = LessonProgress.find_or_initialize_by(user: @user, prep_lesson: lesson)
    progress.update!(status: :completed, completed_at: Time.current)
    progress
  end

  private

  def category_data(category)
    {
      category: category,
      total_lessons: category.prep_lessons.size,
      completed_count: category.completed_count_for(@user),
      progress_percentage: category.progress_percentage_for(@user)
    }
  end

  def overall_progress(categories)
    total = categories.sum { |c| c.prep_lessons.size }
    return 0 if total.zero?

    completed = @user.lesson_progresses.where(status: :completed).count
    (completed.to_f / total * 100).round
  end

  def find_next_lesson(categories)
    categories.each do |cat|
      cat.prep_lessons.each do |lesson|
        status = lesson.status_for(@user)
        return lesson if status == "not_started" || status == "in_progress"
      end
    end
    nil
  end

  def find_last_session_lesson
    last_progress = @user.lesson_progresses
                        .where(status: :in_progress)
                        .order(updated_at: :desc)
                        .first
    last_progress&.prep_lesson
  end

  def weekly_summary
    week_start = Time.current.beginning_of_week
    completed_this_week = @user.lesson_progresses
                               .where(status: :completed)
                               .where("completed_at >= ?", week_start)
                               .count
    total_minutes = @user.lesson_progresses
                         .where("updated_at >= ?", week_start)
                         .sum(:time_spent_minutes)

    { completed_count: completed_this_week, total_minutes: total_minutes }
  end

  def expert_tip
    tips = [
      "When answering behavioral questions, focus on your individual contribution. Use 'I' instead of 'We' to highlight your immediate impact.",
      "For system design interviews, always start with requirements clarification. Spend the first 5 minutes asking questions.",
      "Practice coding problems out loud. Explaining your thought process is as important as getting the right answer.",
      "Use the STAR method (Situation, Task, Action, Result) for behavioral questions to structure your answers clearly."
    ]
    tips.sample(random: Random.new(@user.id + Date.current.yday))
  end

  def resources
    [
      { title: "Scaling Databases: LB Level", icon: "database", color: "cyan" },
      { title: "Big-O Complexity Mastery", icon: "chart", color: "green" },
      { title: "Handling Conflict Situations", icon: "users", color: "orange" }
    ]
  end
end
