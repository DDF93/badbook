import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = { agendaId: Number }

  upvote(event) {
    console.log("Upvote action triggered");
    event.preventDefault();
    this.vote("upvote");
  }

  downvote(event) {
    event.preventDefault();
    this.vote("downvote");
  }

  vote(voteType) {
    const url = `/books/${this.element.dataset.bookId}/sessions/${this.element.dataset.sessionId}/agendas/${this.agendaIdValue}/${voteType}`;
    const token = document.querySelector("meta[name='csrf-token']").getAttribute("content");
    fetch(url, {
      method: 'POST',
      headers: {
        "X-CSRF-Token": token,
        "Accept": "application/json",
        'Content-Type': 'application/json',
      },
      body: JSON.stringify({ agenda_id: this.agendaIdValue }),
    })
    .then(response => response.json())
    .then(data => {
      const upvotes = data.upvotes || 0;
      const downvotes = data.downvotes || 0;
      const score = upvotes - downvotes;

      const upvoteElement = document.querySelector(`#upvote-count-${this.agendaIdValue}`);
      if (upvoteElement) upvoteElement.textContent = `Upvotes: ${upvotes}`;
      const downvoteElement = document.querySelector(`#downvote-count-${this.agendaIdValue}`);
      if (downvoteElement) downvoteElement.textContent = `Downvotes: ${downvotes}`;

      const scoreElement = document.querySelector(`#agenda-calculated-score-${this.agendaIdValue}`);
      if (scoreElement) {
        scoreElement.textContent = `${Math.max(score, 0)}`;
      }

      console.log("Vote registered");
    })
    .catch(error => console.error('Error:', error));
  }



  updateCount(agendaId, voteType) {
    const countElement = this.element.querySelector(`#agenda-${agendaId}-${voteType}-count`);
    if (countElement) {
      let currentCount = parseInt(countElement.textContent, 10);
      currentCount = voteType === "upvote" ? currentCount + 1 : currentCount - 1;
      countElement.textContent = currentCount.toString();
    }
  }
}
