import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["menu"];

  connect() {
    // Add event listener to close dropdown when clicking outside of it
    document.addEventListener('click', this.closeDropdownOutside.bind(this));
  }

  closeDropdownOutside(event) {
    // Check if the clicked element is within the dropdown menu or the button
    if (!this.element.contains(event.target) && !event.target.closest('.dropdown')) {
      this.hideDropdown();
    }
  }

  hideDropdown() {
    // Hide the dropdown menu
    this.menuTarget.classList.add("d-none");
  }

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


  removeFromBookshelf(event) {
    event.preventDefault();
    let bookId = event.target.dataset.bookId; // Get the book_id from the dataset
    let bookshelfId = event.target.dataset.bookshelfId || event.target.parentElement.dataset.bookshelfId;

    fetch("/remove_book_from_bookshelf", {
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

  disconnect() {
    // Remove event listener when the controller is disconnected
    document.removeEventListener('click', this.closeDropdownOutside.bind(this));
  }

}
