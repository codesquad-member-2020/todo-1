import { columnContainer } from "../utils/template";

export default class ColumnContainer {
	constructor({ $target, initialData }) {
		this.$target = $target;
		this.data = initialData;

		this.render();
	}

	render() {
		this.$target.insertAdjacentHTML("beforeend", columnContainer());
	}
}
