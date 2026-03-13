module AdminHelper
  def admin_nav_link(label, path, icon)
    active = request.path.start_with?(path)
    classes = if active
      "flex items-center gap-2 px-3 py-2 text-sm font-medium text-white bg-gray-800 rounded-lg"
    else
      "flex items-center gap-2 px-3 py-2 text-sm text-gray-400 hover:text-white hover:bg-gray-800 rounded-lg transition"
    end

    link_to path, class: classes do
      content_tag(:span, icon, class: "material-symbols-outlined text-lg") + " " + label
    end
  end

  def admin_stat_card(label, value, icon, color: "cyan")
    content_tag(:div, class: "bg-white rounded-xl border border-gray-200 p-5") do
      content_tag(:div, class: "flex items-center justify-between") do
        content_tag(:div) do
          content_tag(:p, label, class: "text-sm text-gray-500") +
          content_tag(:p, value, class: "text-2xl font-bold text-gray-900 mt-1")
        end +
        content_tag(:div, class: "w-12 h-12 bg-#{color}-50 rounded-xl flex items-center justify-center") do
          content_tag(:span, icon, class: "material-symbols-outlined text-#{color}-600")
        end
      end
    end
  end

  def flag_status_badge(status)
    colors = {
      "pending" => "bg-yellow-100 text-yellow-700",
      "reviewing" => "bg-blue-100 text-blue-700",
      "resolved" => "bg-green-100 text-green-700",
      "dismissed" => "bg-gray-100 text-gray-700"
    }
    content_tag(:span, status.humanize, class: "inline-flex items-center px-2 py-0.5 text-xs font-medium rounded-full #{colors[status]}")
  end
end
