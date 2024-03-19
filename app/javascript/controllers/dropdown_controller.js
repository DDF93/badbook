// dropdown_controller.js
import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["menu"];

  toggle() {
    this.menuTarget.classList.toggle("d-none");
  }

  addToBookshelf(event) {
    event.preventDefault();
    let bookId = event.target.dataset.bookId; // Get the book_id from the dataset
    let bookshelfId = event.target.dataset.bookshelfId || event.target.parentElement.dataset.bookshelfId;

    fetch("/add_book_to_bookshelf", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        "X-CSRF-Token": document.querySelector('meta[name="csrf-token"]').getAttribute('content')
      },
      body: JSON.stringify({
        book_id: bookId, // Include the book_id in the request payload
        bookshelf_id: bookshelfId
      })
    })
    .then(response => {
      if (response.ok) {
        // Book added successfully
        alert("Book added to bookshelf successfully");
      } else {
        // Failed to add book
        alert("Failed to add book to bookshelf");
      }
    })
    .catch(error => {
      console.error('There was a problem with your fetch operation:', error);
      // Handle error
    });
  }


}
