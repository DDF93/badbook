import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  handleClick(event) {
    event.preventDefault();
    const bookId = this.element.getAttribute("data-book-id"); // Update this line
    const sessionId = this.element.getAttribute("data-session-id"); // Update this line
    console.log("Session ID:", sessionId); // Log the session ID for debugging
    console.log("Book ID:", bookId); // Log the book ID for debugging
const csrfToken = document.querySelector('meta[name="csrf-token"]').getAttribute('content');

fetch(`/books/${bookId}/sessions/${sessionId}/rsvp`, {
  method: "POST",
  headers: {
    "Content-Type": "application/json",
    "X-CSRF-Token": csrfToken // Include CSRF token in the request headers
  },
  credentials: "same-origin"
})
.then(response => {
  if (response.ok) {
    // Update UI to reflect successful RSVP
    console.log("RSVP successful");
  } else {
    // Handle error
    console.error("Failed to RSVP");
  }
})
.catch(error => {
  console.error("Error:", error);
});
  }
}
