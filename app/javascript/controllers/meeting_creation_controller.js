import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["response"];

  connect() {
    console.log("MeetingCreationController connected");
  }

  async startMeeting() {
    const csrfToken = document.querySelector('meta[name="csrf-token"]').content;
    try {
      const response = await fetch("/create_meeting", { // Rails controller endpoint
        method: "POST",
        headers: {
          "Content-Type": "application/json",
          "X-CSRF-Token": csrfToken
        }
      });

      if (!response.ok) {
        throw new Error('Network response was not ok');
      }

      const responseData = await response.json();
      // Update DOM or handle response as needed
      console.log(responseData);
    } catch (error) {
      console.error('There was a problem with the fetch operation:', error);
    }
  }
}
