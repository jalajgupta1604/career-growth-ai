class WebhooksController < ApplicationController
  before_action :authenticate_user!

  def index
    @subscriptions = current_user.webhook_subscriptions.order(created_at: :desc)
  end

  def create
    @subscription = current_user.webhook_subscriptions.build(webhook_params)
    @subscription.secret = SecureRandom.hex(20)

    if @subscription.save
      redirect_to webhooks_path, notice: "Webhook created."
    else
      @subscriptions = current_user.webhook_subscriptions.order(created_at: :desc)
      render :index, status: :unprocessable_entity
    end
  end

  def destroy
    subscription = current_user.webhook_subscriptions.find(params[:id])
    subscription.destroy
    redirect_to webhooks_path, notice: "Webhook removed."
  end

  private

  def webhook_params
    params.require(:webhook_subscription).permit(:url, events: [])
  end
end
