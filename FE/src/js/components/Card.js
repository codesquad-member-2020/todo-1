import { card } from "../utils/template";

export default class Card {
	$cardContainer = null;

	constructor({ $target, data }) {
		this.$target = $target;
		this.data = data;
		this.render();
	}

	render() {
		this.$cardContainer = this.$target.$cardContainer;
		this.$cardContainer.insertAdjacentHTML("afterbegin", card(this.data));
	}
}
