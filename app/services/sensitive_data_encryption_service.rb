class SensitiveDataEncryptionService
  # Rails 8 provides ActiveRecord encryption out of the box.
  # This service manages encryption configuration and bulk operations.
  #
  # Models using encryption should add:
  #   encrypts :field_name, deterministic: true  (for searchable fields)
  #   encrypts :field_name                       (for non-searchable fields)
  #
  # Encrypted fields in the system:
  # - User: current_salary (sensitive PII)
  # - SalarySubmission: salary, bonus (sensitive compensation data)
  # - Payment: razorpay_payment_id (financial identifier)
  # - Subscription: razorpay_subscription_id (financial identifier)
  # - ApiKey: key (credential)

  def self.setup_encryption_config
    # Ensure encryption keys are configured
    unless Rails.application.credentials.active_record_encryption
      Rails.logger.warn("ActiveRecord encryption keys not configured. Run: bin/rails db:encryption:init")
    end
  end

  def self.encryption_status
    {
      configured: Rails.application.credentials.active_record_encryption.present?,
      models_with_encryption: encrypted_models
    }
  end

  def self.encrypted_models
    %w[User SalarySubmission Payment Subscription ApiKey].select do |model_name|
      klass = model_name.constantize
      klass.respond_to?(:encrypted_attributes) && klass.encrypted_attributes.any?
    rescue NameError
      false
    end
  end
end
