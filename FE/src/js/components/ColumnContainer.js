import { columnContainer } from "../utils/template";
import Column from "./Column";
import Alert from "./Alert";
import CardEditor from "./CardEditor";

export default class ColumnContainer {
	$columnContainer = null;
	columns = null;
	$selectedCard = null;

	constructor({ $target, initialData }) {
		this.$target = $target;
		this.data = initialData;

		this.render();
		this.bindeEventListener();

		this.alert = new Alert({
			data: { message: "선택하신 카드를 삭제하시겠습니까?", visible: false },
			onConfirm: () => this.deleteCard(),
		});

		this.cardEditor = new CardEditor({
			data: { contents: null, visible: false },
			onSave: (contents) => this.updateCard(contents),
		});
	}

	render() {
		this.$target.insertAdjacentHTML("beforeend", columnContainer());
		this.$columnContainer = this.$target.querySelector(".columns");
		this.columns = this.data.map(
			(column, index) => new Column({ $target: this.$columnContainer, initialData: column, index })
		);
	}

	bindeEventListener() {
		this.$columnContainer.addEventListener("click", (e) => this.handleDeleteRequest(e));
		this.$columnContainer.addEventListener("dblclick", (e) => this.handleUpdateRequest(e));
	}

	handleDeleteRequest(e) {
		e.stopImmediatePropagation();
		if (e.target.classList.contains("delete-card")) {
			this.alert.toggleDisplay({ visible: true });
			this.$selectedCard = e.target.parentElement;
		}
	}

	deleteCard() {
		const { $selectedCard } = this;
		const selectedColumn = this.columns.find(
			(column) => column.$column === $selectedCard.closest(".column")
		);
		selectedColumn.deleteCard({ $card: $selectedCard, id: $selectedCard.dataset.id });
	}

	handleUpdateRequest(e) {
		const classList = e.target.classList;
		const isCard =
			classList.contains("card") ||
			classList.contains("contents") ||
			classList.contains("fa-sticky-note");
		if (isCard) {
			this.$selectedCard = e.target.closest(".card");
			const contents = [...this.$selectedCard.children].find(
				(element) => element.className === "contents"
			).textContent;
			this.cardEditor.toggleDisplay({ contents, visible: true });
		}
	}

	updateCard(contents) {
		const { $selectedCard } = this;
		const selectedColumn = this.columns.find(
			(column) => column.$column === $selectedCard.closest(".column")
		);

		selectedColumn.updateCard({ $card: $selectedCard, id: $selectedCard.dataset.id, contents });
	}
}
