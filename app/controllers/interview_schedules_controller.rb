class InterviewSchedulesController < ApplicationController
  before_action :authenticate_user!

  def index
    @upcoming = InterviewSchedule.where(candidate: current_user)
                                 .where(status: %w[pending confirmed rescheduled])
                                 .where("scheduled_at > ?", Time.current)
                                 .order(scheduled_at: :asc)
    @past = InterviewSchedule.where(candidate: current_user)
                             .where("scheduled_at < ?", Time.current)
                             .order(scheduled_at: :desc)
                             .page(params[:page]).per(10)
  end

  def show
    @schedule = InterviewSchedule.find(params[:id])
    redirect_to interview_schedules_path, alert: "Not authorized." unless @schedule.candidate_id == current_user.id
  end

  def confirm
    schedule = InterviewSchedule.find(params[:id])
    if schedule.candidate_id == current_user.id
      schedule.confirm!
      redirect_to interview_schedule_path(schedule), notice: "Interview confirmed."
    else
      redirect_to interview_schedules_path, alert: "Not authorized."
    end
  end
end
