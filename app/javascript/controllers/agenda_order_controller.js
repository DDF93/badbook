import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
    connect() {
        this.sortAgendaItems();

        document.addEventListener('vote:cast', () => {
            this.sortAgendaItems();
        });
    }

    sortAgendaItems() {
        const agendaContainer = this.element;
        const agendaItems = Array.from(agendaContainer.children);

        agendaItems.sort((a, b) => {
            const scoreA = parseInt(a.querySelector('.score').textContent);
            const scoreB = parseInt(b.querySelector('.score').textContent);
            return scoreB - scoreA;
        });

        agendaItems.forEach(item => agendaContainer.appendChild(item));
    }
}
