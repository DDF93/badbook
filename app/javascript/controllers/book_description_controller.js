import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["link", "preview", "full"]

  toggleDescription(event) {
    event.preventDefault();

    if (this.fullTarget.style.display === "none") {
      this.previewTarget.style.display = "none";
      this.fullTarget.style.display = "block";
      this.linkTarget.textContent = "Less";
    } else {
      this.previewTarget.style.display = "block";
      this.fullTarget.style.display = "none";
      this.linkTarget.textContent = "More";
    }
  }
}
