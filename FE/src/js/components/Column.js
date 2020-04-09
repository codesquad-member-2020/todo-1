import { column } from "../utils/template";
import data from "../data";
import Card from "./Card";
import CardCreator from "./CardCreator";

export default class Column {
	$column = null;
	$columnHeader = null;
	$columnBody = null;
	$cardContainer = null;
	cardCreatorIsShowing = false;
	cards = [];

	constructor({ $target, data }) {
		this.$target = $target;
		this.data = data;

		this.render();
		this.cacheDomElements();
		this.bindeEventListener();

		this.renderCards();

		this.cardCreator = new CardCreator({
			$target: this,
			data: {
				visible: false,
			},
		});
	}

	render() {
		const { columnName, cards } = this.data;
		this.$target.insertAdjacentHTML("beforeend", column(columnName, cards.length));
	}

	cacheDomElements() {
		this.$column = [...this.$target.children][this.data.index];
		this.$columnHeader = this.$column.querySelector(".column__header");
		this.$columnBody = this.$column.querySelector(".column__body");
		this.$cardContainer = this.$column.querySelector(".card-container");
	}

	bindeEventListener() {
		const addCardButton = this.$columnHeader.querySelector(".add-card");
		addCardButton.addEventListener("click", this.handleCardCreator.bind(this));
	}

	renderCards() {
		const {
			$cardContainer,
			data: { cards },
		} = this;
		if (cards.length !== 0) {
			this.cards = cards.map((card) => new Card({ $target: $cardContainer, data: card }));
		}
	}

	handleCardCreator() {
		if (!this.cardCreatorIsShowing) {
			this.cardCreator.toggleDisplay({ visible: true });
			this.cardCreatorIsShowing = true;
		} else {
			this.cardCreator.toggleDisplay({ visible: false });
			this.cardCreatorIsShowing = false;
		}
	}

	createCardObj(data) {
		return {
			userId: "reese",
			title: data,
			contents: null,
			device: "web",
			row: this.cards.length + 1,
		};
	}

	addCard(value) {
		const data = this.createCardObj(value);
		const newCard = new Card({ $target: this.$cardContainer, data });
		this.cards.push(newCard);
	}
}
