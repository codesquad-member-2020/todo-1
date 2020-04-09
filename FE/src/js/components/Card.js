import { card } from "../utils/template";

export default class Card {
	constructor({ $target, data }) {
		this.$target = $target;
		this.data = data;
		this.render();
		this.bindeEventListener();
	}

	render() {
		this.$target.insertAdjacentHTML("afterbegin", card(this.data));
	}

	bindeEventListener() {
		this.$target.addEventListener("click", (e) => this.deleteCard(e));
	}

	deleteCard(e) {
		e.stopImmediatePropagation();
		console.log(e.target);
	}
}
