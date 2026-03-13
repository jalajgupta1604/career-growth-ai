class SalaryForecastsController < ApplicationController
  before_action :authenticate_user!

  def index
    @forecasts = current_user.salary_forecasts.recent.limit(10)
  end

  def create
    service = SalaryForecastService.new(current_user)
    @forecast = service.generate_forecast
    if @forecast.completed?
      redirect_to salary_forecast_path(@forecast), notice: "Forecast generated!"
    else
      redirect_to salary_forecasts_path, alert: "Forecast generation failed. Please try again."
    end
  end

  def show
    @forecast = current_user.salary_forecasts.find(params[:id])
  end
end
