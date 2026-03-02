Rails.application.config.gemini_api_key = ENV["GEMINI_API_KEY"]
Rails.application.config.gemini_model = "gemini-2.5-flash"

if Rails.application.config.gemini_api_key.blank?
  Rails.logger.warn("GEMINI_API_KEY is not set. AI features will use rule-based fallbacks.")
end
