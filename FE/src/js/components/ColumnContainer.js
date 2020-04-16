import { columnContainer } from "../utils/template";
import Column from "./Column";
import ColumnCreator from "./ColumnCreator";
import Alert from "./Alert";
import CardEditor from "./CardEditor";

export default class ColumnContainer {
	$columnContainer = null;
	columns = null;
	$selectedCard = null;
	$fromColumn = null;
	$toColumn = null;
	$cardListOfToColumn = null;
	toIndex = 0;
	dragging = false;
	timer = null;

	constructor({ $target, initialData }) {
		this.$target = $target;
		this.data = initialData;

		this.render();
		this.bindEventListener();

		this.alert = new Alert({
			data: { message: "선택하신 카드를 삭제하시겠습니까?", visible: false },
			onConfirm: () => this.deleteCard(),
		});

		this.cardEditor = new CardEditor({
			data: { title: null, contents: null, visible: false },
			onSave: (title, contents) => this.updateCard(title, contents),
		});
	}

	render() {
		this.$target.insertAdjacentHTML("beforeend", columnContainer());
		this.$columnContainer = this.$target.querySelector(".columns");
		this.columns = this.data.map(
			(column, index) => new Column({ $target: this.$columnContainer, initialData: column, index })
		);
		new ColumnCreator({ $target: this.$target });
	}

	bindEventListener() {
		this.$columnContainer.addEventListener("click", (e) => this.handleDeleteRequest(e));
		this.$columnContainer.addEventListener("dblclick", (e) => this.handleUpdateRequest(e));
		this.$target.addEventListener("dragstart", (e) => this.dragStart(e));
		this.$target.addEventListener("dragover", (e) => this.dragOver(e));
		this.$target.addEventListener("drop", (e) => this.drop(e));
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
		const selectedColumn = this.findColumn();
		selectedColumn.deleteCard({ $card: $selectedCard, id: $selectedCard.dataset.id });
	}

	findColumn() {
		return this.columns.find((column) => column.$column === this.$selectedCard.closest(".column"));
	}

	handleUpdateRequest(e) {
		const classList = e.target.classList;
		const isCard =
			classList.contains("card") ||
			classList.contains("card-wrapper") ||
			classList.contains("title") ||
			classList.contains("contents") ||
			classList.contains("user-info") ||
			classList.contains("user-id") ||
			classList.contains("fa-sticky-note");

		if (isCard) {
			this.$selectedCard = e.target.closest(".card");
			const title = this.$selectedCard.querySelector(".title").textContent;
			const contents = this.$selectedCard.querySelector(".contents").textContent;
			this.cardEditor.toggleDisplay({ title, contents, visible: true });
		}
	}

	updateCard(title, contents) {
		const { $selectedCard } = this;
		const selectedColumn = this.findColumn();
		selectedColumn.updateCard({
			$card: $selectedCard,
			id: $selectedCard.dataset.id,
			data: { title, contents },
		});
	}

	dragStart(e) {
		if (e.target.className !== "card") return;
		e.dataTransfer.setData("text/plain", e.target.dataset.id);
		this.$selectedCard = e.target;
		this.$fromColumn = e.target.closest(".column");
		this.$selectedCard.classList.add("selected");
	}

	dragOver(e) {
		e.preventDefault();
		this.$toColumn = e.target.closest(".column");
		if (!this.$toColumn) return;
		this.dragging = true;
		this.updateCardList();
		this.handlePosition(e.clientY);
		this.handleAfterImage();
	}

	updateCardList() {
		let { $fromColumn, $toColumn, $selectedCard } = this;
		this.$cardListOfToColumn = new Set([...$toColumn.querySelector(".card-container").children]);
		if ($fromColumn !== $toColumn) {
			this.$cardListOfToColumn.add($selectedCard);
		}
	}

	handlePosition(currentYPos) {
		this.setCardPositions();
		this.getCurrentPosition(currentYPos);
	}

	setCardPositions() {
		this.$cardListOfToColumn.forEach(($card) => {
			const position = $card.getBoundingClientRect();
			const yTop = position.top;
			const yBottom = position.bottom;
			$card.yPos = yTop + (yBottom - yTop) / 2;
		});
	}

	getCurrentPosition(currentYPos) {
		let cardAbove;
		[...this.$cardListOfToColumn].forEach(($card, i) => {
			if ($card.yPos < currentYPos) {
				cardAbove = $card;
				this.toIndex = i + 1;
			}
		});
		if (!cardAbove) {
			this.toIndex = 0;
		}
	}

	handleAfterImage() {
		this.makeAfterImageForFromColumn();
		this.makeAfterImageForToColumn();
	}

	makeAfterImageForFromColumn() {
		if (this.timer) {
			clearTimeout(this.timer);
		}
		this.timer = setTimeout(() => {
			if (this.$fromColumn === this.$toColumn && this.dragging) {
				this.$fromColumn.querySelector(".card-container").removeChild(this.$selectedCard);
			}
		}, 5000);
	}

	makeAfterImageForToColumn() {
		const targetCardContainer = this.$toColumn.querySelector(".card-container");
		targetCardContainer.insertBefore(
			this.$selectedCard,
			targetCardContainer.children[this.toIndex]
		);
	}

	drop(e) {
		e.preventDefault();

		this.$toColumn = e.target.closest(".column");
		if (!this.$toColumn) {
			this.$selectedCard.classList.remove("selected");
			return;
		}

		this.$selectedCard.classList.remove("selected");
		this.dragging = false;

		e.dataTransfer.getData("text");
		e.dataTransfer.clearData();
		this.moveCard();
	}

	moveCard() {
		const cardId = this.$selectedCard.dataset.id;
		const fromColumnId = this.$fromColumn.dataset.id;
		const toColumnId = this.$toColumn.dataset.id;
		const toRow = [...this.$cardListOfToColumn].indexOf(this.$selectedCard);

		const fromColumn = this.columns.find((column) => column.$column === this.$fromColumn);
		const toColumn = this.columns.find((column) => column.$column === this.$toColumn);

		fromColumn.handleCounter("down");
		toColumn.handleCounter("up");
		toColumn.moveCard({ cardId, fromColumnId, toColumnId, toRow });
	}
}
