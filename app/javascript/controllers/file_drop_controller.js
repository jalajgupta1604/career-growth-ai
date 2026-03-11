import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input", "zone", "fileName", "fileNameText"]

  connect() {
    this.zoneTarget.addEventListener("dragover", this.dragOver.bind(this))
    this.zoneTarget.addEventListener("dragleave", this.dragLeave.bind(this))
    this.zoneTarget.addEventListener("drop", this.drop.bind(this))
  }

  dragOver(e) {
    e.preventDefault()
    e.stopPropagation()
    this.zoneTarget.classList.add("border-cyan-400", "bg-cyan-50")
    this.zoneTarget.classList.remove("border-cyan-200", "bg-cyan-50/30")
  }

  dragLeave(e) {
    e.preventDefault()
    e.stopPropagation()
    this.zoneTarget.classList.remove("border-cyan-400", "bg-cyan-50")
    this.zoneTarget.classList.add("border-cyan-200", "bg-cyan-50/30")
  }

  drop(e) {
    e.preventDefault()
    e.stopPropagation()
    this.zoneTarget.classList.remove("border-cyan-400", "bg-cyan-50")
    this.zoneTarget.classList.add("border-cyan-200", "bg-cyan-50/30")

    const files = e.dataTransfer.files
    if (files.length === 0) return

    const file = files[0]
    const validTypes = [
      "application/pdf",
      "application/vnd.openxmlformats-officedocument.wordprocessingml.document"
    ]
    const validExtensions = [".pdf", ".docx"]
    const ext = file.name.toLowerCase().slice(file.name.lastIndexOf("."))

    if (!validTypes.includes(file.type) && !validExtensions.includes(ext)) {
      alert("Please upload a PDF or DOCX file.")
      return
    }

    // Assign the dropped file to the hidden file input
    const dataTransfer = new DataTransfer()
    dataTransfer.items.add(file)
    this.inputTarget.files = dataTransfer.files

    this.showFile(file.name)
  }

  showFile(name) {
    if (this.hasFileNameTarget) {
      this.fileNameTarget.classList.remove("hidden")
      this.fileNameTextTarget.textContent = name
    }
  }

  // Called from onchange on the file input
  selected() {
    const file = this.inputTarget.files[0]
    if (file) this.showFile(file.name)
  }
}
