import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["show-mark"];


  toggleRead(event) {
    event.preventDefault();
    const button = event.currentTarget;
    const bookId = button.dataset.bookId;
    const bookshelfId =
      button.dataset.bookshelfId || button.parentElement.dataset.bookshelfId;

      fetch("/add_book_to_bookshelf", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        "X-CSRF-Token": document
          .querySelector('meta[name="csrf-token"]')
          .getAttribute("content"),
      },
      body: JSON.stringify({
        book_id: bookId,
        bookshelf_id: bookshelfId,
      }),
    })
      .then((response) => {
        if (response.ok) {
          button.outerHTML = `<button
            class="show-read-status-btn read"
            data-controller="show-mark"
            data-show-mark-target="show-mark"
            data-bookshelf-id=${bookshelfId}
            data-book-id=${bookId}
            data-toggle="tooltip"
            data-action="click->show-mark#remove"
            title="Mark as unread"
          >
          <i class="fa fa-check"></i>
          </button>`;
          button.classList.toggle("read");
        } else {
          alert("Whoops, action failed. Please try again.");
        }
      })
      .catch((error) => {
        console.error("There was a problem with your fetch operation:", error);
      });
  }

  remove(event) {
    event.preventDefault();
    const button = event.currentTarget;
    const bookId = button.dataset.bookId;
    const bookshelfId = button.dataset.bookshelfId;

    fetch(`/remove_book_from_bookshelf`, {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        "X-CSRF-Token": document
          .querySelector('meta[name="csrf-token"]')
          .getAttribute("content"),
      },
      body: JSON.stringify({
        book_id: bookId,
        bookshelf_id: bookshelfId,
      }),
    })
      .then((response) => {
        if (response.ok) {
          button.classList.remove("read");
          button.outerHTML = `<button
            class="show-read-status-btn"
            data-controller="show-mark"
            data-show-mark-target="show-mark"
            data-bookshelf-id=${bookshelfId}
            data-book-id=${bookId}
            data-toggle="tooltip"
            data-action="click->show-mark#toggleRead"
            title="Mark as read"
          >
          <i class="fa fa-check"></i>
          </button>`;
          button.classList.toggle("read");
        }
      })
      .catch((error) => {
        console.error("Error:", error);
      });
  }


}
