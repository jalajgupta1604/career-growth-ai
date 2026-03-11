module ApplicationHelper
  def user_avatar(user, size: "w-8 h-8", extra_class: "")
    fallback = user.default_avatar_url
    tag.img(
      src: user.avatar_url,
      class: "#{size} rounded-full object-cover #{extra_class}".strip,
      alt: user.full_name || "User",
      onerror: "this.onerror=null;this.src='#{j(fallback)}';"
    )
  end
end
