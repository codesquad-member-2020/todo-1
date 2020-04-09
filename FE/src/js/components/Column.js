import { column } from "../utils/template";
import Card from "./Card";

export default class Column {
	$column = null;
	cards = null;

	constructor({ $target, data }) {
		this.$target = $target;
		this.data = data;

		this.render();
	}

	render() {
		const { columnName, index, cards } = this.data;
		this.$target.insertAdjacentHTML("beforeend", column(columnName, cards.length));
		this.$column = [...this.$target.children][index].querySelector(".column__body");
		this.cards = cards.map((card) => new Card({ $target: this.$column, data: card }));
	}
}
