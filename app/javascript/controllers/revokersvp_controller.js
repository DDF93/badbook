import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  handleClick(event) {
    event.preventDefault();

    const bookId = this.element.getAttribute("data-book-id");
    const sessionId = this.element.getAttribute("data-session-id");

    console.log("Session ID:", sessionId);
    console.log("Book ID:", bookId);

    const csrfToken = document.querySelector('meta[name="csrf-token"]').getAttribute('content');

    fetch(`/books/${bookId}/sessions/${sessionId}/rsvp`, {
      method: "DELETE",  // Send a DELETE request
      headers: {
        "Content-Type": "application/json",
        "X-CSRF-Token": csrfToken
      },
      credentials: "same-origin"
    })
    .then(response => {
      if (response.ok) {
        console.log("RSVP revoked successfully");
        // Update UI to reflect successful RSVP revocation
        this.showNotification("RSVP revoked successfully");
      } else {
        console.error("Failed to revoke RSVP");
        // Handle error or update UI accordingly
        this.showNotification("Failed to revoke RSVP");
      }
    })
    .catch(error => {
      console.error("Error:", error);
      // Handle error or update UI accordingly
      this.showNotification("An error occurred");
    });
  }

  showNotification(message) {
    // You can implement your own notification system here
    alert(message); // For simplicity, using JavaScript's alert function
  }
}
