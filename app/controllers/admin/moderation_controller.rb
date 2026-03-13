module Admin
  class ModerationController < BaseController
    def index
      @flags = ContentFlag.unresolved.includes(:user, :flaggable).recent
      @flags = @flags.page(params[:page]).per(20)
      @resolved_count = ContentFlag.where(status: [:resolved, :dismissed]).count
    end

    def resolve
      @flag = ContentFlag.find(params[:id])
      @flag.resolve!(current_user, notes: params[:notes])
      audit!("resolve_flag", resource: @flag, metadata: { notes: params[:notes] })
      redirect_to admin_moderation_index_path, notice: "Flag resolved."
    end

    def dismiss
      @flag = ContentFlag.find(params[:id])
      @flag.dismiss!(current_user, notes: params[:notes])
      audit!("dismiss_flag", resource: @flag, metadata: { notes: params[:notes] })
      redirect_to admin_moderation_index_path, notice: "Flag dismissed."
    end
  end
end
