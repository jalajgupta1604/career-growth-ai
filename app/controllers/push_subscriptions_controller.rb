class PushSubscriptionsController < ApplicationController
  before_action :authenticate_user!
  skip_before_action :verify_authenticity_token, only: [:create]

  def create
    sub = current_user.push_subscriptions.find_or_initialize_by(endpoint: params[:endpoint])
    sub.update!(
      p256dh_key: params[:p256dh_key],
      auth_key: params[:auth_key]
    )
    render json: { success: true }
  rescue => e
    render json: { error: e.message }, status: :unprocessable_entity
  end

  def destroy
    current_user.push_subscriptions.where(endpoint: params[:endpoint]).destroy_all
    render json: { success: true }
  end
end
