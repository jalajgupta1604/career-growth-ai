class InterviewSchedulingService
  def initialize(employer_profile)
    @employer = employer_profile
  end

  def schedule(job_application:, params:)
    schedule = InterviewSchedule.create!(
      job_application: job_application,
      employer_profile: @employer,
      candidate: job_application.user,
      title: params[:title],
      round_type: params[:round_type] || "screening",
      scheduled_at: params[:scheduled_at],
      duration_minutes: params[:duration_minutes] || 60,
      meeting_link: params[:meeting_link],
      location: params[:location],
      notes: params[:notes]
    )

    NotificationService.notify(
      user: job_application.user,
      title: "Interview Scheduled",
      body: "#{@employer.company_name} has scheduled a #{schedule.round_type} interview for #{schedule.time_display}.",
      category: "interview",
      action_url: "/interview_schedules/#{schedule.id}"
    )

    schedule
  end

  def reschedule(schedule, new_time:, reason: nil)
    schedule.update!(
      scheduled_at: new_time,
      status: "rescheduled",
      notes: [schedule.notes, "Rescheduled: #{reason}"].compact.join("\n")
    )

    NotificationService.notify(
      user: schedule.candidate,
      title: "Interview Rescheduled",
      body: "Your interview with #{@employer.company_name} has been rescheduled to #{schedule.time_display}.",
      category: "interview",
      action_url: "/interview_schedules/#{schedule.id}"
    )

    schedule
  end

  def upcoming_for_candidate(user)
    InterviewSchedule.where(candidate: user)
                     .where(status: %w[pending confirmed rescheduled])
                     .where("scheduled_at > ?", Time.current)
                     .order(scheduled_at: :asc)
  end

  def upcoming_for_employer
    InterviewSchedule.where(employer_profile: @employer)
                     .where(status: %w[pending confirmed rescheduled])
                     .where("scheduled_at > ?", Time.current)
                     .order(scheduled_at: :asc)
  end
end
