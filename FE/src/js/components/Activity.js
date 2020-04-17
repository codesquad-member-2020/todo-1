import { activity, activityList } from "../utils/template";

export default class Header {
	$activity = null;
	$close = null;
	$detailContainer = null;

	constructor({ $target, data }) {
		this.$target = $target;
		this.data = data;
		this.render();
		this.cacheDomElements();
		this.bindEventListener();
	}

	render() {
		document.getElementById("Todo").insertAdjacentHTML("afterend", activity());
	}

	cacheDomElements() {
		this.$activity = document.querySelector(".activity");
		this.$close = this.$activity.querySelector(".close-activity");
		this.$detailContainer = this.$activity.querySelector(".activity-detail");
	}

	bindEventListener() {
		this.$close.addEventListener("click", this.closeActivity.bind(this));
	}

	clearList() {
		const detailList = this.$detailContainer.querySelector("ul");
		if (detailList) {
			this.$detailContainer.removeChild(detailList);
		}
	}

	appendList(data) {
		this.$detailContainer.insertAdjacentHTML("afterbegin", activityList(data.activities));
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

	openActivity(data) {
		this.appendList(data);
		this.toggleDisplay({ visible: true });
	}

	closeActivity() {
		this.toggleDisplay({ visible: false });
		this.clearList();
	}
}
