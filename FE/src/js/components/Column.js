import { column } from "../utils/template";

export default class Column {
	constructor({ $target, data }) {
		this.$target = $target;

		const { columnName, id, index, cards } = data;
		this.render(columnName, cards.length);
	}

	render(columnName, numOfCards) {
		this.$target.insertAdjacentHTML("beforeend", column(columnName, numOfCards));
	}
}
