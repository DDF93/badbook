import { Controller } from "stimulus";

export default class extends Controller {
  submit(event) {
    event.preventDefault();
    const form = event.currentTarget;
    const formData = new FormData(form);


    fetch(form.action, {
      method: form.method,
      headers: {
        "X-CSRF-Token": document
          .querySelector('meta[name="csrf-token"]')
          .getAttribute("content"),
      },
      body: formData,
    })
      .then((response) => response.json())
      .then((data) => {
        if (data.message) {
          alert(data.message);
          // Optionally, close the modal
          const modal = form.closest(".modal");
          const modalInstance = bootstrap.Modal.getInstance(modal);
          modalInstance.hide();

          const dropdownMenu = document.querySelector(
            '[data-dropdown-target="menu"]'
          );
          const newBookshelfItem = document.createElement("li");
          newBookshelfItem.innerHTML = `
          <a class="dropdown-item" href="#" data-bookshelf-id="${data.bookshelf.id}" data-book-id="<%= book.id %>" data-action="click->dropdown#addToBookshelf">
            ${data.bookshelf.name}
          </a>
        `;
          dropdownMenu.insertBefore(
            newBookshelfItem,
            dropdownMenu.lastElementChild
          );
        } else if (data.error) {
          alert(data.error);
        }
      })
      .catch((error) => {
        console.error("Error:", error);
        // Handle error
      });
  }
}
