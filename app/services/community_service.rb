class CommunityService
  def initialize(user)
    @user = user
  end

  def feed(page: 1, per_page: 20, filter: nil)
    posts = CommunityPost.feed
    posts = posts.where(post_type: filter) if filter.present?
    posts.limit(per_page).offset((page.to_i - 1) * per_page)
  end

  def create_post(params)
    @user.community_posts.create!(
      post_type: params[:post_type] || "milestone",
      title: params[:title],
      content: params[:content],
      anonymous: params[:anonymous] == "1" || params[:anonymous] == true
    )
  end

  def toggle_like(post)
    existing = post.post_likes.find_by(user: @user)
    if existing
      existing.destroy!
      false
    else
      post.post_likes.create!(user: @user)
      true
    end
  end
end
