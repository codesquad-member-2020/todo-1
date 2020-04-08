import { column } from "../utils/template";
import Card from "./Card";

export default class Column {
	cards = null;

	constructor({ $target, data }) {
		this.$target = $target;

		const { columnName, id, index, cards } = data;
		this.render(columnName, cards.length);
		this.createCards(index, cards);
	}

	render(columnName, numOfCards) {
		this.$target.insertAdjacentHTML("beforeend", column(columnName, numOfCards));
	}

	createCards(index, cards) {
		this.$column = [...this.$target.children][index].querySelector(".column__body");
		this.cards = cards.map((card) => new Card({ $target: this.$column, data: card }));
	}
}
