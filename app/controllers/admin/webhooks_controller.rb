module Admin
  class WebhooksController < BaseController
    def index
      @subscriptions = WebhookSubscription.includes(:user).order(created_at: :desc).page(params[:page]).per(20)
    end
  end
end
