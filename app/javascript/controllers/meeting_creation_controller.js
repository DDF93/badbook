import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["response"];

  connect() {console.log("MeetingCreationController connected")};

  async startMeeting() {
    console.log("startMeeting called")
    const API_KEY = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJodHRwczovL2FjY291bnRzLmFwcGVhci5pbiIsImF1ZCI6Imh0dHBzOi8vYXBpLmFwcGVhci5pbi92MSIsImV4cCI6OTAwNzE5OTI1NDc0MDk5MSwiaWF0IjoxNzExMTk1NTY4LCJvcmdhbml6YXRpb25JZCI6MjIwMzUzLCJqdGkiOiI5OTI1YjNkNy0zYWEyLTRhNGMtYmNiNC1lZmFmY2YzYjkxYmIifQ.0VogW3uXqlhLFrfjr7cCDULK3BktOXdA-6oAJc4Exh0";


const proxyUrl = 'https://cors-anywhere.herokuapp.com/';
const apiUrl = 'https://api.whereby.dev/v1/meetings';

try {
  const response = await fetch(proxyUrl + apiUrl, {
    method: 'POST',
    headers: {
      'Authorization': `Bearer ${API_KEY}`,
      'Content-Type': 'application/json'
    },
    body: JSON.stringify({
      "roomMode": "group",
      "fields": ["hostRoomUrl", "viewerRoomUrl"]
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
