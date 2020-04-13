import { header } from "../utils/template";
import Activity from "./Activity";

export default class Header {
	constructor($target) {
		this.$target = $target;
		this.render();

		this.activity = new Activity($target);
	}

	render() {
		this.$target.insertAdjacentHTML("afterbegin", header());
	}
}
