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
			data: { data: null, visible: false },
			onSave: () => console.log("hey, editor!"),
		});
	}

	render() {
		this.$target.insertAdjacentHTML("beforeend", columnContainer());
		this.$columnContainer = this.$target.querySelector(".columns");
		this.columns = this.data.map(
			(column) => new Column({ $target: this.$columnContainer, initialData: column })
		);
	}

	bindeEventListener() {
		this.$columnContainer.addEventListener("click", (e) => this.handleDeleteRequest(e));
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
}
