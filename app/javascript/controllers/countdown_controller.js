import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = { startTime: String }
  static targets = ["time"]

  connect() {
    this.startCountdown();
  }

  startCountdown() {
    const endTime = new Date(this.startTimeValue).getTime();
    const updateTime = () => {
      const now = new Date().getTime();
      const distance = endTime - now;

      if (distance < 0) {
        clearInterval(this.interval);
        this.timeTarget.textContent = "Live Now";
        return;
      }

      const hours = Math.floor((distance % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
      const minutes = Math.floor((distance % (1000 * 60 * 60)) / (1000 * 60));
      const seconds = Math.floor((distance % (1000 * 60)) / 1000);

      this.timeTarget.textContent = `${hours.toString().padStart(2, '0')}:${minutes.toString().padStart(2, '0')}:${seconds.toString().padStart(2, '0')}`;
    };

    this.interval = setInterval(updateTime, 1000);
    updateTime();
  }

  disconnect() {
    clearInterval(this.interval);
  }
}
