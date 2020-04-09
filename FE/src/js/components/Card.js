import { card } from "../utils/template";

export default class Card {
	$cardContainer = null;

	constructor({ $target, data }) {
		this.$target = $target;
		this.data = data;
		this.render();
		this.bindeEventListener();
	}

	render() {
		this.$cardContainer = this.$target.$cardContainer;
		this.$cardContainer.insertAdjacentHTML("afterbegin", card(this.data));
	}

	bindeEventListener() {
		this.$cardContainer.addEventListener("click", (e) => this.deleteCard(e));
	}

	deleteCard(e) {
		e.stopImmediatePropagation();
		console.log(e.target);
	}
}
