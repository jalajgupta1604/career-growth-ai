class WebhookDeliveryJob < ApplicationJob
  queue_as :default
  retry_on StandardError, wait: :polynomially_longer, attempts: 3

  def perform(subscription_id, event, payload_json)
    subscription = WebhookSubscription.find_by(id: subscription_id)
    return unless subscription&.active?

    uri = URI.parse(subscription.url)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = uri.scheme == "https"
    http.open_timeout = 5
    http.read_timeout = 10

    request = Net::HTTP::Post.new(uri.path.presence || "/")
    request["Content-Type"] = "application/json"
    request["X-Webhook-Event"] = event
    request["X-Webhook-Signature"] = generate_signature(payload_json, subscription.secret) if subscription.secret.present?
    request.body = payload_json

    response = http.request(request)

    unless response.code.to_i.between?(200, 299)
      subscription.record_failure!
      raise "Webhook delivery failed: #{response.code}"
    end
  rescue => e
    subscription&.record_failure!
    raise e
  end

  private

  def generate_signature(payload, secret)
    OpenSSL::HMAC.hexdigest("SHA256", secret, payload)
  end
end
