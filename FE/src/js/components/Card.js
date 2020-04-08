import { card } from "../utils/template";

export default class Card {
	constructor({ $target, data }) {
		this.$target = $target;
		this.render(data);
	}

	render(data) {
		this.$target.insertAdjacentHTML("beforeend", card(data));
	}
}
