import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["menu"];

  connect() {
    document.addEventListener("click", this.closeDropdownOutside.bind(this));
  }

  closeDropdownOutside(event) {
    if (
      !this.element.contains(event.target) &&
      !event.target.closest(".dropdown")
    ) {
      this.hideDropdown();
    }
  }

  hideDropdown() {
    this.menuTarget.classList.add("d-none");
  }

  toggle() {
    this.menuTarget.classList.toggle("d-none");
  }

  addToBookshelf(event) {
    event.preventDefault();
    const link = event.currentTarget;
    const bookId = link.dataset.bookId;
    const bookshelfId =
      link.dataset.bookshelfId || link.parentElement.dataset.bookshelfId;

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
          link.outerHTML = `
          <a class="dropdown-item"
          href="#"
          data-bookshelf-id=${bookshelfId}
          data-book-id=${bookId}
          data-action="click->dropdown#removeFromBookshelf">
            ${link.textContent} <i class="fa-regular fa-circle-check" style="margin-left: 4px;"></i>
          </a>`;
        } else {
          alert("Failed to add book to bookshelf");
        }
      })
      .catch((error) => {
        console.error("There was a problem with your fetch operation:", error);
      });
  }

  removeFromBookshelf(event) {
    event.preventDefault();
    const link = event.currentTarget;
    const bookId = link.dataset.bookId;
    const bookshelfId =
      link.dataset.bookshelfId || link.parentElement.dataset.bookshelfId;

    fetch("/remove_book_from_bookshelf", {
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
          link.outerHTML = `
          <a class="dropdown-item"
          href="#"
          data-bookshelf-id=${bookshelfId}
          data-book-id=${bookId}
          data-action="click->dropdown#addToBookshelf">
            ${link.textContent} <i class="fa-regular fa-circle" style="margin-left: 4px;"></i>
          </a>`;
        } else {
          alert("Failed to remove book from bookshelf");
        }
      })
      .catch((error) => {
        console.error("There was a problem with your fetch operation:", error);
      });
  }

  disconnect() {
    document.removeEventListener("click", this.closeDropdownOutside.bind(this));
  }
}
