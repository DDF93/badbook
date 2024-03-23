import { Controller } from "stimulus"
import { fetchWithTurboDrive } from "@hotwired/turbo"

export default class extends Controller {
  delete(event) {
    const bookshelfId = event.currentTarget.getAttribute('data-bookshelf-id')

    if(confirm("Are you sure you want to delete this bookshelf and all its books?")) {
      fetchWithTurboDrive(`/bookshelves/${bookshelfId}`, {
        method: 'DELETE',
        dataType: 'script',
        headers: {
          'X-CSRF-Token': document.querySelector("[name='csrf-token']").content,
          'Accept': "text/vnd.turbo-stream.html"
        },
      }).then(response => {
        if (response.ok) {
          console.log("Bookshelf deleted successfully");
        } else {
          alert("There was an error deleting the bookshelf.");
        }
      });
    }
  }
}
