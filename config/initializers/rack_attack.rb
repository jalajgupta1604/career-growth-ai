class Rack::Attack
  # Throttle all requests by IP (300 requests per 5 minutes)
  throttle("req/ip", limit: 300, period: 5.minutes) do |req|
    req.ip unless req.path.start_with?("/assets", "/up")
  end

  # Throttle login attempts by IP (5 per 20 seconds)
  throttle("logins/ip", limit: 5, period: 20.seconds) do |req|
    req.ip if req.path == "/users/sign_in" && req.post?
  end

  # Throttle login attempts by email (5 per minute)
  throttle("logins/email", limit: 5, period: 60.seconds) do |req|
    if req.path == "/users/sign_in" && req.post?
      req.params.dig("user", "email")&.downcase&.strip
    end
  end

  # Stricter throttle for API endpoints (60 per minute)
  throttle("api/ip", limit: 60, period: 1.minute) do |req|
    req.ip if req.path.start_with?("/api/")
  end

  # Throttle report generation (3 per hour)
  throttle("reports/ip", limit: 3, period: 1.hour) do |req|
    req.ip if req.path == "/career_reports" && req.post?
  end

  # Block suspicious requests
  blocklist("block bad agents") do |req|
    Rack::Attack::Fail2Ban.filter("bad-agents-#{req.ip}", maxretry: 3, findtime: 10.minutes, bantime: 1.hour) do
      req.path.include?("wp-admin") || req.path.include?("xmlrpc") || req.path.include?(".env")
    end
  end

  # Custom throttle response
  self.throttled_responder = lambda do |req|
    match_data = req.env["rack.attack.match_data"]
    now = match_data[:epoch_time]
    retry_after = match_data[:period] - (now % match_data[:period])

    [
      429,
      { "Content-Type" => "application/json", "Retry-After" => retry_after.to_s },
      [{ error: "Rate limit exceeded. Retry after #{retry_after} seconds." }.to_json]
    ]
  end
end
