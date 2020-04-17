import { header } from "../utils/template";
import Activity from "./Activity";
import HttpRequestHandler from "../utils/HttpRequestHandler";
import { BASE_URL, NETWORK_MESSAGE } from "../utils/const";
import { handleError } from "../utils/utilFunction";

export default class Header {
	$menuButton = null;
	http = new HttpRequestHandler();

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

	async handleActivityDisplay() {
		try {
			const response = await this.http.get(`${BASE_URL}/activity`);
			if (response.status === 200) {
				this.activity.openActivity(response);
			}
		} catch (err) {
			handleError(err);
		}
	}
}
