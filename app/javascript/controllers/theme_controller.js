import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["toggle"]

  lightTheme = "lofi"
  darkTheme = ""

  connect() {
    this.darkTheme = this.toggleTarget.value
    const savedTheme = localStorage.getItem("theme")

    if (savedTheme) {
      this.setTheme(savedTheme)
    } else {
      this.setTheme(this.lightTheme)
    }
  }

  switch() {
    const theme = this.toggleTarget.checked ? this.darkTheme : this.lightTheme
    this.setTheme(theme)
  }

  setTheme(theme) {
    document.documentElement.setAttribute("data-theme", theme)
    localStorage.setItem("theme", theme)
    this.toggleTarget.checked = (theme === this.darkTheme)
  }
}