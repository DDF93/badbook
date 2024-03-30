import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["capacity", "button", "table", "row"];

  connect() {
    //console.log(this.revokeTarget);
    //console.log(this.acceptTarget);
  }

  handleClick(event) {
    const buttonType = event.target.innerText;

    if (buttonType === "Cancel") {
      this.sendDataToAPI("DELETE", event, "Attend", 1);
    } else if (buttonType === "Attend") {
      this.sendDataToAPI("POST", event, "Cancel", -1);
    }
  }

  sendDataToAPI(method, event, newText, newAmount) {
    const bookId = this.buttonTarget.dataset.bookId;
    const sessionId = this.buttonTarget.dataset.sessionId;
    const url = `/books/${bookId}/sessions/${sessionId}/rsvp`;

    const csrfToken = document
      .querySelector('meta[name="csrf-token"]')
      .getAttribute("content");

    fetch(`/books/${bookId}/sessions/${sessionId}/rsvp`, {
      method: method,
      headers: {
        "Content-Type": "application/json",
        "X-CSRF-Token": csrfToken,
      },
      credentials: "same-origin",
    })
      .then((response) => {
        console.log("RSVP successful");
        this.changeUI(event, newText, newAmount);
      })
      .catch((error) => {
        console.error("Error:", error);
      });
  }

  changeUI(event, newText, newAmount) {
    console.log(event)
    event.target.innerText = newText;
    const newCapacity =
      parseInt(this.capacityTarget.dataset.capacity) + newAmount;
    this.capacityTarget.outerHTML = `<td class="session-capacity" data-rsvp-target="capacity" data-capacity=${newCapacity}><i class="fa-solid fa-users" style="padding-right: 8px;"></i>${newCapacity} ${
      newCapacity === 0 ? "Full" : "spots left"
    } </td>`;

    // Hide the entire row if capacity becomes 0 after cancellation
    event.target.classList.toggle("btn-rsvp");
    event.target.classList.toggle("btn-rsvp-revoke");

    const row = this.rowTarget;
    row.outerHTML = "";

    if ((this.tableTarget.innerHTML === "")) this.tableTarget.outerHTML = "";
    
  }
}
