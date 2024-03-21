import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static values = { agendaId: Number };

  upvote(event) {
    event.preventDefault();
    if (!this.hasVoted()) {
      this.vote("upvote", event.currentTarget);
    } else {
      this.disableButton("upvote-button");
    }
  }

  downvote(event) {
    event.preventDefault();
    if (!this.hasVoted()) {
      this.vote("downvote", event.currentTarget);
    } else {
      this.disableButton("downvote-button");
    }
  }

  hasVoted() {
    return this.element.dataset.voted === "true";
  }

  disableButton(buttonClass) {
    const button = this.element.querySelector(`.${buttonClass}`);
    if (button) {
      button.disabled = true;
    }
  }

  vote(voteType, button) {
    const url = `/books/${this.element.dataset.votingBookIdValue}/sessions/${this.element.dataset.votingSessionIdValue}/agendas/${this.agendaIdValue}/${voteType}`;
    const token = document.querySelector("meta[name='csrf-token']").getAttribute("content");

    const hasVoted = this.hasVoted();
    let method = 'POST';
    if (hasVoted) {
        method = 'DELETE';
    }

    fetch(url, {
        method: method,
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

        const agendaButtons = button.parentElement.querySelectorAll('.circular-button');
        agendaButtons.forEach(btn => {
            btn.classList.remove('selected-vote');
        });
        button.classList.add('selected-vote');

        console.log("Vote registered");
        this.broadcastVote();
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

  broadcastVote() {
    const event = new CustomEvent('vote:cast');
    document.dispatchEvent(event);
  }
}
