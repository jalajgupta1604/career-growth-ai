module Admin
  class PaymentsController < BaseController
    before_action :require_super_admin!

    def refund
      payment = Payment.find(params[:id])

      RefundService.new(payment, admin: current_user, reason: params[:reason]).process!
      audit!("refund_issued", resource: payment, metadata: { amount: payment.amount, reason: params[:reason] })

      redirect_to admin_revenue_path, notice: "Refund of ₹#{payment.amount / 100} issued successfully."
    rescue => e
      redirect_to admin_revenue_path, alert: "Refund failed: #{e.message}"
    end
  end
end
