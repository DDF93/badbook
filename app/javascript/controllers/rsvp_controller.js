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
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        "X-CSRF-Token": csrfToken
      },
      credentials: "same-origin"
    })
    .then(response => {
      if (response.ok) {
        response.json().then(data => {
          console.log("RSVP successful");
          window.location.href = data.session_path;
        });
      } else {
        console.error("Failed to RSVP");
        this.showNotification("Failed to RSVP", false);
        response.json().then(data => {
          if(data.error) {
            console.error("Error message:", data.error);
            this.showNotification(data.error);
          }
        });
      }
    })
    .catch(error => {
      console.error("Error:", error);
      this.showNotification("An error occurred");
    });
  }

  showNotification(message) {
    alert(message);
  }
}
