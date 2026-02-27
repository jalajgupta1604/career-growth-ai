module InterviewPrepHelper
  COLOR_MAP = {
    "cyan" => {
      bg: "bg-cyan-50",
      bg_dark: "bg-cyan-500",
      text: "text-cyan-600",
      border: "border-cyan-200",
      bar: "bg-cyan-500",
      light: "bg-cyan-100"
    },
    "green" => {
      bg: "bg-green-50",
      bg_dark: "bg-green-500",
      text: "text-green-600",
      border: "border-green-200",
      bar: "bg-green-500",
      light: "bg-green-100"
    },
    "purple" => {
      bg: "bg-purple-50",
      bg_dark: "bg-purple-500",
      text: "text-purple-600",
      border: "border-purple-200",
      bar: "bg-purple-500",
      light: "bg-purple-100"
    },
    "orange" => {
      bg: "bg-orange-50",
      bg_dark: "bg-orange-500",
      text: "text-orange-600",
      border: "border-orange-200",
      bar: "bg-orange-500",
      light: "bg-orange-100"
    }
  }.freeze

  def prep_color(color_key, variant)
    COLOR_MAP.dig(color_key.to_s, variant.to_sym) || "bg-gray-100"
  end
end
