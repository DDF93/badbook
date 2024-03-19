import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="modal"
export default class extends Controller {
  submit(event) {
    event.preventDefault();
    const form = event.currentTarget;
    const formData = new FormData(form);

    fetch(form.action, {
      method: form.method,
      headers: {
        "X-CSRF-Token": document.querySelector('meta[name="csrf-token"]').getAttribute('content')
      },
      body: formData
    })
    .then(response => response.json())
    .then(data => {
      if (data.message) {
        alert(data.message);
        // Optionally, close the modal
        const modal = form.closest('.modal');
        const modalInstance = bootstrap.Modal.getInstance(modal);
        modalInstance.hide();
      } else if (data.error) {
        alert(data.error);
      }
    })
    .catch(error => {
      console.error('Error:', error);
      // Handle error
    });
  }
}
