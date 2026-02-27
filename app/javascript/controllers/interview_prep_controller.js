import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["sidebar"]

  toggleSidebar() {
    const sidebar = this.sidebarTarget
    sidebar.classList.toggle("hidden")
    sidebar.classList.toggle("fixed")
    sidebar.classList.toggle("inset-0")
    sidebar.classList.toggle("z-50")
  }
}
