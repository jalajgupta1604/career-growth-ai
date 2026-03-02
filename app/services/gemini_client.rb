class GeminiClient
  API_BASE = "https://generativelanguage.googleapis.com/v1beta/models"
  DEFAULT_TIMEOUT = 30

  def initialize
    @api_key = Rails.application.config.gemini_api_key
    @model = Rails.application.config.gemini_model
  end

  def generate(prompt, response_schema: nil)
    return nil if @api_key.blank?

    body = build_request_body(prompt, response_schema)
    response = connection.post(endpoint_path, body.to_json)

    if response.success?
      parse_response(response.body, response_schema)
    else
      Rails.logger.error("Gemini API error: #{response.status} — #{response.body}")
      nil
    end
  rescue Faraday::TimeoutError
    Rails.logger.error("Gemini API timeout")
    nil
  rescue => e
    Rails.logger.error("Gemini API unexpected error: #{e.message}")
    nil
  end

  private

  def connection
    @connection ||= Faraday.new(url: API_BASE) do |f|
      f.options.timeout = DEFAULT_TIMEOUT
      f.options.open_timeout = 10
      f.request :retry, max: 2, interval: 1, retry_statuses: [429, 500, 502, 503]
      f.headers["Content-Type"] = "application/json"
      f.adapter Faraday.default_adapter
    end
  end

  def endpoint_path
    "/#{@model}:generateContent?key=#{@api_key}"
  end

  def build_request_body(prompt, response_schema)
    body = {
      contents: [{ parts: [{ text: prompt }] }],
      generationConfig: { temperature: 0.7 }
    }

    if response_schema
      body[:generationConfig][:responseMimeType] = "application/json"
      body[:generationConfig][:responseSchema] = response_schema
    end

    body
  end

  def parse_response(body, response_schema)
    data = JSON.parse(body)
    text = data.dig("candidates", 0, "content", "parts", 0, "text")
    return nil unless text

    if response_schema
      JSON.parse(text)
    else
      text
    end
  rescue JSON::ParserError => e
    Rails.logger.error("Gemini response parse error: #{e.message}")
    nil
  end
end
