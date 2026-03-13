class DataExportsController < ApplicationController
  before_action :authenticate_user!

  def show
  end

  def request_export
    if current_user.data_export_requested_at.present? && current_user.data_export_requested_at > 24.hours.ago
      redirect_to data_export_path, alert: "You already have a pending export request. Please wait 24 hours."
      return
    end

    current_user.update!(data_export_requested_at: Time.current)
    DataExportJob.perform_later(current_user.id)
    redirect_to data_export_path, notice: "Your data export has been requested. You'll receive a notification when it's ready."
  end

  def request_deletion
    if current_user.deletion_requested_at.present?
      redirect_to data_export_path, alert: "Account deletion already requested."
      return
    end

    current_user.update!(
      deletion_requested_at: Time.current,
      deletion_scheduled_at: 30.days.from_now
    )
    redirect_to data_export_path, notice: "Account deletion scheduled for #{30.days.from_now.strftime('%B %d, %Y')}. You can cancel anytime before then."
  end

  def cancel_deletion
    current_user.update!(deletion_requested_at: nil, deletion_scheduled_at: nil)
    redirect_to data_export_path, notice: "Account deletion cancelled."
  end
end
