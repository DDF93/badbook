import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["mark"];

  toggleRead(event) {
    event.preventDefault();
    const button = this.markTarget; // Access the static target
    console.log(button.dataset.bookId);
    console.log(button.dataset.bookshelfId);
    let bookId = button.dataset.bookId; // Get the book_id from the dataset
    let bookshelfId = button.dataset.bookshelfId || button.parentElement.dataset.bookshelfId;

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
        alert("Success!");
      } else {
        // Failed to add book
        alert("Whoops, action failed. Please try again.");
      }
    })
    .catch(error => {
      console.error('There was a problem with your fetch operation:', error);
      // Handle error
    });
  }
}
