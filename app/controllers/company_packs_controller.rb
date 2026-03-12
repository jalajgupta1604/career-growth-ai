class CompanyPacksController < ApplicationController
  before_action :authenticate_user!

  def index
    @packs = CompanyPack.ordered
  end

  def show
    @pack = CompanyPack.find_by!(slug: params[:slug])
  end
end
