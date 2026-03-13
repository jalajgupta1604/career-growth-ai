class ApiKeysController < ApplicationController
  before_action :authenticate_user!

  def index
    @api_keys = current_user.api_keys.order(created_at: :desc)
  end

  def create
    @key = current_user.api_keys.build(name: params[:api_key][:name])
    if @key.save
      redirect_to api_keys_path, notice: "API key created! Key: #{@key.key}"
    else
      redirect_to api_keys_path, alert: @key.errors.full_messages.join(", ")
    end
  end

  def destroy
    key = current_user.api_keys.find(params[:id])
    key.update!(active: false)
    redirect_to api_keys_path, notice: "API key deactivated."
  end
end
