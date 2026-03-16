module EnterpriseHelper
  def enterprise_nav_link(label, path, icon)
    active = request.path == path || (path != enterprise_root_path && request.path.start_with?(path))
    classes = if active
      "flex items-center gap-2.5 px-3 py-2 text-sm font-medium text-white bg-emerald-800/60 rounded-lg"
    else
      "flex items-center gap-2.5 px-3 py-2 text-sm text-emerald-200 hover:text-white hover:bg-emerald-900/50 rounded-lg transition"
    end

    link_to path, class: classes do
      content_tag(:span, icon, class: "material-symbols-outlined text-lg") + " " + label
    end
  end
end
