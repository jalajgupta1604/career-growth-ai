if defined?(Sentry) && ENV["SENTRY_DSN"].present?
  Sentry.init do |config|
    config.dsn = ENV["SENTRY_DSN"]
    config.breadcrumbs_logger = [:active_support_logger, :http_logger]
    config.traces_sample_rate = ENV.fetch("SENTRY_TRACES_RATE", 0.1).to_f
    config.profiles_sample_rate = ENV.fetch("SENTRY_PROFILES_RATE", 0.1).to_f
    config.send_default_pii = false

    config.excluded_exceptions += [
      "ActionController::RoutingError",
      "ActiveRecord::RecordNotFound",
      "ActionController::InvalidAuthenticityToken"
    ]

    config.before_send = lambda do |event, hint|
      # Strip sensitive params
      if event.request&.data.is_a?(Hash)
        event.request.data = event.request.data.except("password", "password_confirmation", "token", "secret")
      end
      event
    end
  end
end
