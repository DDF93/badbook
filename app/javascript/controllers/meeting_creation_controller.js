import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="meeting-creation"
export default class extends Controller {
  static targets = ["response"];

  connect() {console.log("MeetingCreationController connected")}

  async startMeeting() {
    const API_KEY = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJodHRwczovL2FjY291bnRzLmFwcGVhci5pbiIsImF1ZCI6Imh0dHBzOi8vYXBpLmFwcGVhci5pbi92MSIsImV4cCI6OTAwNzE5OTI1NDc0MDk5MSwiaWF0IjoxNzExMTk1NTY4LCJvcmdhbml6YXRpb25JZCI6MjIwMzUzLCJqdGkiOiI5OTI1YjNkNy0zYWEyLTRhNGMtYmNiNC1lZmFmY2YzYjkxYmIifQ.0VogW3uXqlhLFrfjr7cCDULK3BktOXdA-6oAJc4Exh0";
    // const data = {
    //   endDate: "2099-02-18T14:23:00.000Z",
    //   fields: ["hostRoomUrl"],
    //   roomMode:["group"],
    // };

    try {
      const endDate = new Date();
      endDate.setHours(endDate.getHours() + 1);
      const response = await fetch("https://api.whereby.dev/v1/meetings", {
        method: "POST",
        headers: {
          Authorization: `Bearer ${API_KEY}`,
          "Content-Type": "application/json"
        },
        body: JSON.stringify({
          "roomMode": "group",
          "fields": ["hostRoomUrl", "viewerRoomUrl"],
          "endDate": endDate.toISOString()
        })
      });

      const responseData = await response.json();
      console.log(responseData);
      this.responseTarget.textContent = `Room URL: ${responseData.roomUrl}, Host room URL: ${responseData.hostRoomUrl}`;
    } catch (error) {
      console.error('There was a problem with the fetch operation:', error);
    }
  }
}
