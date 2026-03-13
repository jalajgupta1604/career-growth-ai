class RevisionsController < ApplicationController
  before_action :authenticate_user!

  def index
    @service = SpacedRepetitionService.new(current_user)
    @stats = @service.stats
    @heatmap = @service.weakness_heatmap
    @due_items = @service.due_items(10)
  end

  def practice
    @service = SpacedRepetitionService.new(current_user)
    @items = @service.revision_session(5)
    @current_index = params[:index].to_i
    @item = @items[@current_index] || @items.first

    redirect_to revisions_path, notice: "No items due for review. Great job!" if @item.nil?
  end

  def review
    @item = current_user.revision_items.find(params[:id])
    quality = params[:quality].to_i
    SpacedRepetitionService.new(current_user).review_item!(@item, quality)
    redirect_to practice_revisions_path(index: params[:next_index].to_i), notice: "Reviewed! Next review in #{@item.interval} day#{'s' if @item.interval != 1}."
  end
end
