module InterviewPrepHelper
  COLOR_MAP = {
    "cyan" => {
      bg: "bg-indigo-50",
      bg_dark: "bg-indigo-500",
      text: "text-indigo-500",
      border: "border-indigo-200",
      bar: "bg-indigo-500",
      light: "bg-indigo-50",
      icon: "account_tree"
    },
    "green" => {
      bg: "bg-emerald-50",
      bg_dark: "bg-emerald-500",
      text: "text-emerald-500",
      border: "border-emerald-200",
      bar: "bg-emerald-500",
      light: "bg-emerald-50",
      icon: "code_blocks"
    },
    "purple" => {
      bg: "bg-orange-50",
      bg_dark: "bg-orange-500",
      text: "text-orange-500",
      border: "border-orange-200",
      bar: "bg-orange-500",
      light: "bg-orange-50",
      icon: "forum"
    },
    "orange" => {
      bg: "bg-rose-50",
      bg_dark: "bg-rose-500",
      text: "text-rose-500",
      border: "border-rose-200",
      bar: "bg-rose-500",
      light: "bg-rose-50",
      icon: "record_voice_over"
    }
  }.freeze

  def prep_color(color_key, variant)
    COLOR_MAP.dig(color_key.to_s, variant.to_sym) || "bg-gray-100"
  end
end
