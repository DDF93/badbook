import { Controller } from "@hotwired/stimulus";

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
      const hostRoomUrl = responseData.hostRoomUrl;
      this.responseTarget.innerHTML = `<iframe src="${hostRoomUrl}" allow="camera; microphone; fullscreen; speaker; display-capture; compute-pressure" style="height: 700px; width: 100%"></iframe>`;
    } catch (error) {
      console.error('There was a problem with the fetch operation:', error);
    }
  }
}
