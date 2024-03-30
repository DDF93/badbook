import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["response", "chat"];

  connect() {
    console.log("MeetingCreationController connected");
  }

  async startMeeting(event) {
    const sessionId = event.target.dataset.sessionId;
    const csrfToken = document.querySelector('meta[name="csrf-token"]').content;
    try {
      const response = await fetch("/create_meeting", {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
          "X-CSRF-Token": csrfToken
        },
        body: JSON.stringify({ sessionId: sessionId }) // Pass session ID in the request body
      });

      if (!response.ok) {
        throw new Error('Network response was not ok');
      }

      const responseData = await response.json();
      const hostRoomUrl = responseData.hostRoomUrl;
      this.responseTarget.innerHTML = `<iframe src="${hostRoomUrl}" allow="camera; microphone; fullscreen; speaker; display-capture; compute-pressure" style="height: 700px; width: 100%"></iframe>`;


      this.chatTarget.style.display = "none";
    } catch (error) {
      console.error('There was a problem with the fetch operation:', error);
    }
  }
}
