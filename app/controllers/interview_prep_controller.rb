class InterviewPrepController < ApplicationController
  before_action :authenticate_user!

  def show
    service = InterviewPrepService.new(current_user)
    @data = service.dashboard_data
  end

  def lesson
    @lesson = PrepLesson.find(params[:id])
    @category = @lesson.prep_category
    @status = @lesson.status_for(current_user)
    @siblings = @category.prep_lessons
    @current_index = @siblings.index(@lesson)
    @prev_lesson = @current_index && @current_index > 0 ? @siblings[@current_index - 1] : nil
    @next_lesson = @current_index && @current_index < @siblings.size - 1 ? @siblings[@current_index + 1] : nil
  end

  def start_lesson
    lesson = PrepLesson.find(params[:lesson_id])
    InterviewPrepService.new(current_user).mark_lesson_started(lesson)
    redirect_to interview_prep_lesson_path(lesson)
  end

  def complete_lesson
    lesson = PrepLesson.find(params[:lesson_id])
    InterviewPrepService.new(current_user).mark_lesson_completed(lesson)
    redirect_to interview_prep_lesson_path(lesson), notice: "Lesson completed!"
  end
end
