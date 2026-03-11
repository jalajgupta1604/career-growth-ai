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

  def ai_practice_questions(lesson)
    cache_key = "gemini/interview_questions/user_#{@user.id}/lesson_#{lesson.id}"

    Rails.cache.fetch(cache_key, expires_in: 24.hours) do
      category_name = lesson.prep_category.name
      topic = lesson.topic
      difficulty = lesson.difficulty_label
      role = @user.role || "Software Developer"

      prompt = GeminiPrompts.interview_questions_prompt(category_name, topic, difficulty, role)
      result = GeminiClient.new.generate(prompt, response_schema: interview_questions_schema)
      return [] unless result

      questions = result["questions"] || result
      questions = [questions] unless questions.is_a?(Array)
      questions.map do |q|
        {
          "question" => q["question"].to_s,
          "model_answer" => q["model_answer"].to_s,
          "difficulty" => q["difficulty"].to_s
        }
      end
    end
  rescue => e
    Rails.logger.error("AI interview questions failed: #{e.message}")
    []
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
    last_week_start = 1.week.ago.beginning_of_week
    completed_this_week = @user.lesson_progresses
                               .where(status: :completed)
                               .where("completed_at >= ?", week_start)
                               .count
    completed_last_week = @user.lesson_progresses
                               .where(status: :completed)
                               .where("completed_at >= ? AND completed_at < ?", last_week_start, week_start)
                               .count
    total_minutes = @user.lesson_progresses
                         .where("updated_at >= ?", week_start)
                         .sum(:time_spent_minutes)

    improvement_pct = if completed_last_week > 0
      (((completed_this_week - completed_last_week).to_f / completed_last_week) * 100).round
    else
      completed_this_week > 0 ? 100 : 0
    end

    { completed_count: completed_this_week, total_minutes: total_minutes, last_week_count: completed_last_week, improvement_percentage: improvement_pct }
  end

  def expert_tip
    tips = [
      { text: "When answering behavioral questions, focus on your individual contribution. Use 'I' instead of 'We' to highlight your immediate impact.", attribution: "MAANG_ARCHITECT_AMAZON" },
      { text: "For system design interviews, always start with requirements clarification. Spend the first 5 minutes asking questions.", attribution: "MAANG_ARCHITECT_GOOGLE" },
      { text: "Practice coding problems out loud. Explaining your thought process is as important as getting the right answer.", attribution: "MAANG_ARCHITECT_META" },
      { text: "Use the STAR method (Situation, Task, Action, Result) for behavioral questions to structure your answers clearly.", attribution: "MAANG_ARCHITECT_MICROSOFT" }
    ]
    tips.sample(random: Random.new(@user.id + Date.current.yday))
  end

  def resources
    categories = PrepCategory.ordered.includes(:prep_lessons).limit(3)
    categories.map do |cat|
      first_lesson = cat.prep_lessons.first
      next nil unless first_lesson

      {
        title: first_lesson.title,
        description: cat.name,
        lesson: first_lesson,
        duration: first_lesson.duration_minutes,
        status: first_lesson.status_for(@user)
      }
    end.compact
  end

  def interview_questions_schema
    {
      type: "OBJECT",
      properties: {
        questions: {
          type: "ARRAY",
          items: {
            type: "OBJECT",
            properties: {
              question: { type: "STRING" },
              model_answer: { type: "STRING" },
              difficulty: { type: "STRING" }
            }
          }
        }
      }
    }
  end
end
