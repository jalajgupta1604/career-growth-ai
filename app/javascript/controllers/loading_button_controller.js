import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = { text: { type: String, default: "Processing..." } }

  submit() {
    const button = this.element.querySelector("button[type='submit'], input[type='submit']")
    if (!button || button.disabled) return

    button.disabled = true
    button.classList.add("opacity-75", "pointer-events-none")
    button.innerHTML = `
      <span class="inline-flex items-center gap-2">
        <svg class="animate-spin h-4 w-4" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24">
          <circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4"></circle>
          <path class="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4z"></path>
        </svg>
        ${this.textValue}
      </span>
    `
  }
}
