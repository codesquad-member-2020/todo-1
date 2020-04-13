import { activity } from "../utils/template";
import activityData from "../activityData";

export default class Header {
	$activity = null;
	$close = null;

	constructor({ $target, data }) {
		this.$target = $target;
		this.data = data;
		this.render();
		this.cacheDomElements();
		this.bindEventListener();
	}

	render() {
		document.getElementById("Todo").insertAdjacentHTML("afterend", activity(activityData));
	}

	cacheDomElements() {
		this.$activity = document.querySelector(".activity");
		this.$close = this.$activity.querySelector(".close-activity");
	}

	bindEventListener() {
		this.$close.addEventListener("click", this.toggleDisplay.bind(this, { visible: false }));
	}

	toggleDisplay(nextData) {
		this.data = nextData;
		const {
			$activity,
			data: { visible },
		} = this;
		visible
			? ($activity.style.transform = "translateX(-360px)")
			: ($activity.style.transform = "translateX(0px)");
	}
}
