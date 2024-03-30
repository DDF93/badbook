import { Controller } from "@hotwired/stimulus"
import { createConsumer } from "@rails/actioncable"

export default class extends Controller {
  static values = { chatroomId: Number, currentUserId: Number }
  static targets = ["messages"]

  connect() {
    this.channel = createConsumer().subscriptions.create(
      { channel: "ChatroomChannel", id: this.chatroomIdValue },
      { received: data => this.handleReceivedData(data) }
    )
    console.log(`Subscribed to the chatroom with the id ${this.chatroomIdValue}.`)
  }

  handleReceivedData(data) {
    if (data.message) {
      // Handle regular messages
      this.insertMessageAndScrollDown(data);
    } else if (data.action === 'initiate_call') {
      // Handle 'initiate call' action
      this.initiateCall();
    }
  }

  justifyClass(currentUserIsSender) {
    return currentUserIsSender ? "justify-content-end" : "justify-content-start"
  }

  userStyleClass(currentUserIsSender) {
    return currentUserIsSender ? "sender-style" : "receiver-style"
  }

  buildMessageElement(currentUserIsSender, message) {
    return `
      <div class="message-row d-flex ${this.justifyClass(currentUserIsSender)}">
        <div class="${this.userStyleClass(currentUserIsSender)}">
          ${message}
        </div>
      </div>
    `
  }

  insertMessageAndScrollDown(data) {
    const currentUserIsSender = this.currentUserIdValue === data.sender_id;
    const messageElement = this.buildMessageElement(currentUserIsSender, data.message);
    this.messagesTarget.insertAdjacentHTML("beforeend", messageElement);
    this.messagesTarget.scrollTo(0, this.messagesTarget.scrollHeight);
  }

  initiateCall() {
    // Execute the JavaScript method for initiating the call
    // Replace this with your actual method call
    console.log("Initiating call...");
  }

  resetForm(event) {
    event.target.reset()
  }

  disconnect() {
    console.log("Unsubscribed from the chatroom")
    this.channel.unsubscribe()
  }
}
