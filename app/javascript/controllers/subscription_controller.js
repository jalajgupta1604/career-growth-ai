import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = {
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

  async subscribe(event) {
    event.preventDefault()
    const button = event.currentTarget
    const plan = button.dataset.plan
    const originalText = button.textContent
    button.disabled = true
    button.textContent = "Processing..."

    try {
      const csrfToken = document.querySelector('meta[name="csrf-token"]')?.content
      const response = await fetch("/subscriptions", {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
          "X-CSRF-Token": csrfToken,
          "Accept": "application/json"
        },
        body: JSON.stringify({ plan: plan })
      })

      if (!response.ok) {
        const error = await response.json()
        throw new Error(error.error || "Failed to create subscription")
      }

      const subData = await response.json()
      this.openCheckout(subData, button, originalText)
    } catch (error) {
      console.error("Subscription error:", error)
      alert("Subscription failed: " + error.message)
      button.disabled = false
      button.textContent = originalText
    }
  }

  openCheckout(subData, button, originalText) {
    const controller = this

    const options = {
      key: subData.key,
      subscription_id: subData.subscription_id,
      name: "Career Growth AI",
      description: subData.plan_name === "yearly" ? "Pro Yearly Plan" : "Pro Monthly Plan",
      prefill: {
        name: this.userNameValue,
        email: this.userEmailValue
      },
      method: {
        upi: true,
        card: true,
        netbanking: true,
        wallet: true,
        emandate: true
      },
      theme: {
        color: "#06b6d4"
      },
      handler: function (response) {
        controller.verifyPayment(response, button, originalText)
      },
      modal: {
        ondismiss: function () {
          button.disabled = false
          button.textContent = originalText
        }
      }
    }

    const rzp = new Razorpay(options)
    rzp.on("payment.failed", function (response) {
      console.error("Payment failed:", response.error)
      alert("Payment failed: " + response.error.description)
      button.disabled = false
      button.textContent = originalText
    })
    rzp.open()
  }

  async verifyPayment(paymentResponse, button, originalText) {
    button.textContent = "Verifying..."

    try {
      const csrfToken = document.querySelector('meta[name="csrf-token"]')?.content
      const response = await fetch("/subscriptions/verify", {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
          "X-CSRF-Token": csrfToken,
          "Accept": "application/json"
        },
        body: JSON.stringify({
          razorpay_subscription_id: paymentResponse.razorpay_subscription_id,
          razorpay_payment_id: paymentResponse.razorpay_payment_id,
          razorpay_signature: paymentResponse.razorpay_signature
        })
      })

      const result = await response.json()

      if (result.success) {
        window.location.reload()
      } else {
        throw new Error(result.error || "Verification failed")
      }
    } catch (error) {
      console.error("Verification error:", error)
      alert("Payment verification failed. If money was deducted, it will be refunded. Please contact support.")
      button.disabled = false
      button.textContent = originalText
    }
  }
}
