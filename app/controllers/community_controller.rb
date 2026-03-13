class CommunityController < ApplicationController
  before_action :authenticate_user!

  def index
    @service = CommunityService.new(current_user)
    @filter = params[:filter]
    @posts = @service.feed(page: params[:page], filter: @filter)
  end

  def create
    @service = CommunityService.new(current_user)
    @post = @service.create_post(post_params)
    redirect_to community_index_path, notice: "Post shared with the community!"
  rescue ActiveRecord::RecordInvalid => e
    redirect_to community_index_path, alert: e.message
  end

  def like
    post = CommunityPost.find(params[:id])
    liked = CommunityService.new(current_user).toggle_like(post)
    redirect_to community_index_path, notice: liked ? "Post liked!" : "Like removed"
  end

  private

  def post_params
    params.require(:community_post).permit(:post_type, :title, :content, :anonymous)
  end
end
