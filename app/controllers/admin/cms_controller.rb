module Admin
  class CmsController < BaseController
    def index
      @contents = CmsContent.ordered
      @contents = @contents.by_type(params[:type]) if params[:type].present?
      @contents = @contents.page(params[:page]).per(20)
    end

    def new
      @content = CmsContent.new(content_type: params[:type] || "lesson")
    end

    def create
      @content = CmsContent.new(content_params)
      @content.author = current_user

      if @content.save
        audit!("create_content", resource: @content)
        redirect_to admin_cms_index_path, notice: "Content created."
      else
        render :new, status: :unprocessable_entity
      end
    end

    def edit
      @content = CmsContent.find(params[:id])
    end

    def update
      @content = CmsContent.find(params[:id])
      if @content.update(content_params)
        audit!("update_content", resource: @content)
        redirect_to admin_cms_index_path, notice: "Content updated."
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def publish
      @content = CmsContent.find(params[:id])
      @content.publish!
      audit!("publish_content", resource: @content)
      redirect_to admin_cms_index_path, notice: "\"#{@content.title}\" published."
    end

    def archive
      @content = CmsContent.find(params[:id])
      @content.archive!
      audit!("archive_content", resource: @content)
      redirect_to admin_cms_index_path, notice: "Content archived."
    end

    private

    def content_params
      params.require(:cms_content).permit(:content_type, :title, :slug, :body, :status, :position)
    end
  end
end
