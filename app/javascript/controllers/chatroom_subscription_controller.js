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
    switch(data.action) {
      case 'execute_function':
        this.handleExecuteFunction(data);
        break;
      case 'message':
        this.handleChatMessage(data);
        break;

    }
  }

  handleExecuteFunction(data) {
    switch(data.function_name) {
      case 'handleInitiateCall':
        this.handleInitiateCall();
        break;

    }
  }

  handleChatMessage(data) {
    const currentUserIsSender = this.currentUserIdValue === data.sender_id
    const messageElement = this.buildMessageElement(currentUserIsSender, data.message)
    this.messagesTarget.insertAdjacentHTML("beforeend", messageElement)
    this.messagesTarget.scrollTo(0, this.messagesTarget.scrollHeight)
  }

  handleInitiateCall() {
    console.log("Initiating call...");

  }

  executeFunction(functionName, functionArguments) {
    // You can implement logic here to execute the specified function
    // For example:
    window[functionName](...functionArguments)
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

  justifyClass(currentUserIsSender) {
    return currentUserIsSender ? "justify-content-end" : "justify-content-start"
  }

  userStyleClass(currentUserIsSender) {
    return currentUserIsSender ? "sender-style" : "receiver-style"
  }

  resetForm(event) {
    event.target.reset()
  }

  disconnect() {
    console.log("Unsubscribed from the chatroom")
    this.channel.unsubscribe()
  }
}
