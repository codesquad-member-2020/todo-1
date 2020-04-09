import { card } from "../utils/template";

export default class Card {
	constructor({ $target, data }) {
		this.$target = $target;
		this.data = data;
		this.render();
	}

	render() {
		this.$target.insertAdjacentHTML("afterbegin", card(this.data));
	}
}
