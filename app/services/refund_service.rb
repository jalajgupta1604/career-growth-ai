class RefundService
  def initialize(payment, admin:, reason: nil)
    @payment = payment
    @admin = admin
    @reason = reason
  end

  def process!
    raise "Payment not eligible for refund" unless @payment.captured?
    raise "Payment already refunded" if @payment.refunded?

    if @payment.razorpay_payment_id.present?
      refund = Razorpay::Payment.fetch(@payment.razorpay_payment_id).refund(amount: @payment.amount)
      razorpay_refund_id = refund.id
    end

    @payment.update!(
      status: :refunded,
      razorpay_refund_id: razorpay_refund_id,
      refunded_at: Time.current,
      refund_reason: @reason,
      refunded_by: @admin
    )

    AuditLog.track(
      user: @admin,
      action: "refund_issued",
      resource: @payment,
      metadata: { amount: @payment.amount, reason: @reason }
    )

    NotificationService.notify(
      @payment.user,
      title: "Refund processed",
      body: "A refund of ₹#{@payment.amount / 100} has been issued to your account.",
      category: "subscription"
    )

    @payment
  rescue Razorpay::Error => e
    Rails.logger.error("Razorpay refund failed: #{e.message}")
    raise "Refund failed: #{e.message}"
  end
end
