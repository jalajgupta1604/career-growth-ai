module Admin
  class ModerationController < BaseController
    def index
      @flags = ContentFlag.unresolved.includes(:user, :flaggable).recent
      @flags = @flags.page(params[:page]).per(20)
      @resolved_count = ContentFlag.where(status: [:resolved, :dismissed]).count
      @pending_posts = CommunityPost.pending_review.recent.limit(10)
    end

    def resolve
      @flag = ContentFlag.find(params[:id])
      @flag.resolve!(current_user, notes: params[:notes])

      # If the flagged content is a community post, update moderation status
      if @flag.flaggable.is_a?(CommunityPost)
        @flag.flaggable.update!(moderation_status: "rejected")
      end

      audit!("resolve_flag", resource: @flag, metadata: { notes: params[:notes] })
      redirect_to admin_moderation_index_path, notice: "Flag resolved."
    end

    def dismiss
      @flag = ContentFlag.find(params[:id])
      @flag.dismiss!(current_user, notes: params[:notes])

      # If dismissed, approve the post
      if @flag.flaggable.is_a?(CommunityPost) && @flag.flaggable.moderation_status == "pending_review"
        @flag.flaggable.update!(moderation_status: "approved")
      end

      audit!("dismiss_flag", resource: @flag, metadata: { notes: params[:notes] })
      redirect_to admin_moderation_index_path, notice: "Flag dismissed."
    end
  end
end
