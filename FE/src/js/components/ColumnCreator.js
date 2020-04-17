import { columnCreator } from "../utils/template";

export default class ColumnCreator {
	constructor({ $target }) {
		this.$target = $target;
		this.render();
	}

	render() {
		this.$target
			.querySelector(".columns-container")
			.insertAdjacentHTML("beforeend", columnCreator());
	}
}
