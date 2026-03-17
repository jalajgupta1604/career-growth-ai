module Employer
  class SchedulesController < BaseController
    def index
      service = InterviewSchedulingService.new(current_employer)
      @upcoming = service.upcoming_for_employer
      @past = InterviewSchedule.where(employer_profile: current_employer)
                               .where("scheduled_at < ?", Time.current)
                               .order(scheduled_at: :desc)
                               .page(params[:page]).per(20)
    end

    def new
      @application = JobApplication.find(params[:application_id])
      @schedule = InterviewSchedule.new
    end

    def create
      @application = JobApplication.find(params[:interview_schedule][:job_application_id])
      service = InterviewSchedulingService.new(current_employer)

      @schedule = service.schedule(
        job_application: @application,
        params: schedule_params
      )

      redirect_to employer_schedules_path, notice: "Interview scheduled for #{@schedule.time_display}."
    rescue ActiveRecord::RecordInvalid => e
      redirect_to employer_schedules_path, alert: e.message
    end

    def show
      @schedule = InterviewSchedule.find(params[:id])
    end

    def confirm
      schedule = InterviewSchedule.find(params[:id])
      schedule.confirm!
      redirect_to employer_schedule_path(schedule), notice: "Interview confirmed."
    end

    def complete
      schedule = InterviewSchedule.find(params[:id])
      schedule.complete!(
        feedback: params[:interviewer_feedback],
        rating: params[:rating]
      )
      redirect_to employer_schedule_path(schedule), notice: "Interview marked as completed."
    end

    def cancel
      schedule = InterviewSchedule.find(params[:id])
      schedule.cancel!
      NotificationService.notify(
        user: schedule.candidate,
        title: "Interview Cancelled",
        body: "Your interview with #{current_employer.company_name} has been cancelled.",
        category: "interview"
      )
      redirect_to employer_schedules_path, notice: "Interview cancelled."
    end

    private

    def schedule_params
      params.require(:interview_schedule).permit(
        :title, :round_type, :scheduled_at, :duration_minutes,
        :meeting_link, :location, :notes
      )
    end
  end
end
