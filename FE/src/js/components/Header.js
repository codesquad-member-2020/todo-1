import { header } from "../utils/template";

export default class Header {
	constructor($target) {
		this.$target = $target;
		this.render();
	}

	render() {
		this.$target.insertAdjacentHTML("afterbegin", header());
	}
}
