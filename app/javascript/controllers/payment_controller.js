import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = {
    reportId: Number,
    keyId: String,
    userName: String,
    userEmail: String
  }

  connect() {
    this.loadRazorpayScript()
  }

  loadRazorpayScript() {
    if (document.querySelector('script[src="https://checkout.razorpay.com/v1/checkout.js"]')) return

    const script = document.createElement("script")
    script.src = "https://checkout.razorpay.com/v1/checkout.js"
    script.async = true
    document.head.appendChild(script)
  }

  async pay(event) {
    event.preventDefault()
    const button = event.currentTarget
    button.disabled = true
    button.textContent = "Processing..."

    try {
      // Step 1: Create Razorpay order via server
      const csrfToken = document.querySelector('meta[name="csrf-token"]')?.content
      const response = await fetch("/payments", {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
          "X-CSRF-Token": csrfToken,
          "Accept": "application/json"
        },
        body: JSON.stringify({ career_report_id: this.reportIdValue })
      })

      if (!response.ok) {
        const error = await response.json()
        throw new Error(error.error || "Failed to create payment order")
      }

      const orderData = await response.json()

      // Step 2: Open Razorpay checkout
      this.openCheckout(orderData, button)
    } catch (error) {
      console.error("Payment error:", error)
      alert("Payment failed: " + error.message)
      button.disabled = false
      button.textContent = "Unlock Full Report — ₹999"
    }
  }

  openCheckout(orderData, button) {
    const controller = this

    const options = {
      key: orderData.key,
      amount: orderData.amount,
      currency: orderData.currency,
      name: "Career Growth AI",
      description: "Full Career Blueprint Report",
      order_id: orderData.order_id,
      prefill: {
        name: this.userNameValue,
        email: this.userEmailValue
      },
      theme: {
        color: "#06b6d4"
      },
      handler: function (response) {
        controller.verifyPayment(response, button)
      },
      modal: {
        ondismiss: function () {
          button.disabled = false
          button.textContent = "Unlock Full Report — ₹999"
        }
      }
    }

    const rzp = new Razorpay(options)
    rzp.on("payment.failed", function (response) {
      console.error("Payment failed:", response.error)
      alert("Payment failed: " + response.error.description)
      button.disabled = false
      button.textContent = "Unlock Full Report — ₹999"
    })
    rzp.open()
  }

  async verifyPayment(paymentResponse, button) {
    button.textContent = "Verifying..."

    try {
      const csrfToken = document.querySelector('meta[name="csrf-token"]')?.content
      const response = await fetch("/payments/verify", {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
          "X-CSRF-Token": csrfToken,
          "Accept": "application/json"
        },
        body: JSON.stringify({
          razorpay_order_id: paymentResponse.razorpay_order_id,
          razorpay_payment_id: paymentResponse.razorpay_payment_id,
          razorpay_signature: paymentResponse.razorpay_signature
        })
      })

      const result = await response.json()

      if (result.success) {
        // Reload page to show unlocked content
        window.location.reload()
      } else {
        throw new Error(result.error || "Verification failed")
      }
    } catch (error) {
      console.error("Verification error:", error)
      alert("Payment verification failed. If money was deducted, it will be refunded. Please contact support.")
      button.disabled = false
      button.textContent = "Unlock Full Report — ₹999"
    }
  }
}
