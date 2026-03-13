class InvoicesController < ApplicationController
  before_action :authenticate_user!

  def index
    @invoices = current_user.invoices.recent.page(params[:page]).per(10)
  end

  def show
    @invoice = current_user.invoices.find(params[:id])
  end
end
