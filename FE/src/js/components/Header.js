import { header } from "../utils/template";
import Activity from "./Activity";

export default class Header {
	$menuButton = null;

	constructor($target) {
		this.$target = $target;
		this.render();
		this.cacheDomElements();
		this.bindEventListener();

		this.activity = new Activity({ $target, data: { visible: false } });
	}

	render() {
		this.$target.insertAdjacentHTML("afterbegin", header());
	}

	cacheDomElements() {
		this.$menuButton = this.$target.querySelector(".menu");
	}

	bindEventListener() {
		this.$menuButton.addEventListener("click", this.handleActivityDisplay.bind(this));
	}

	handleActivityDisplay() {
		this.activity.toggleDisplay({ visible: true });
	}
}
