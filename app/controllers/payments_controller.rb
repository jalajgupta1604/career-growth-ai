class PaymentsController < ApplicationController
  before_action :authenticate_user!, except: [:webhook]
  skip_before_action :verify_authenticity_token, only: [:webhook]

  REPORT_PRICE = 999_00 # ₹999 in paise

  def create
    @report = current_user.career_reports.find(params[:career_report_id])

    razorpay_order = Razorpay::Order.create(
      amount: REPORT_PRICE,
      currency: "INR",
      receipt: "report_#{@report.id}"
    )

    @payment = Payment.create!(
      user: current_user,
      career_report: @report,
      razorpay_order_id: razorpay_order.id,
      amount: 999,
      status: :pending
    )

    render json: {
      order_id: razorpay_order.id,
      amount: REPORT_PRICE,
      currency: "INR",
      key: ENV.fetch("RAZORPAY_KEY_ID", "")
    }
  rescue => e
    Rails.logger.error("Payment creation failed: #{e.message}")
    render json: { error: "Payment creation failed" }, status: :unprocessable_entity
  end

  def verify
    payment = current_user.payments.find_by(razorpay_order_id: params[:razorpay_order_id])

    unless payment
      render json: { success: false, error: "Payment not found" }, status: :not_found
      return
    end

    begin
      Razorpay::Utility.verify_payment_signature(
        razorpay_order_id: params[:razorpay_order_id],
        razorpay_payment_id: params[:razorpay_payment_id],
        razorpay_signature: params[:razorpay_signature]
      )

      payment.update!(
        razorpay_payment_id: params[:razorpay_payment_id],
        status: :captured
      )
      payment.career_report.update!(payment_status: :paid)

      render json: { success: true, message: "Payment verified successfully" }
    rescue Razorpay::Error, SecurityError => e
      payment.update!(status: :failed)
      Rails.logger.error("Payment verification failed: #{e.message}")
      render json: { success: false, error: "Payment verification failed" }, status: :unprocessable_entity
    end
  end

  def webhook
    payload = request.body.read
    signature = request.headers["X-Razorpay-Signature"]

    begin
      Razorpay::Utility.verify_webhook_signature(payload, signature, ENV.fetch("RAZORPAY_WEBHOOK_SECRET", ""))
    rescue Razorpay::Error
      head :bad_request
      return
    end

    event = JSON.parse(payload)
    handle_payment_event(event)
    head :ok
  end

  private

  def handle_payment_event(event)
    return unless event["event"] == "payment.captured"

    payment_entity = event.dig("payload", "payment", "entity")
    order_id = payment_entity["order_id"]

    payment = Payment.find_by(razorpay_order_id: order_id)
    return unless payment

    payment.update!(
      razorpay_payment_id: payment_entity["id"],
      status: :captured
    )
    payment.career_report.update!(payment_status: :paid)

    PdfGenerationJob.perform_later(payment.career_report.id)
  end
end
