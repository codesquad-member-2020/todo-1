import { header } from "../utils/template";
import Activity from "./Activity";
import HttpRequestHandler from "../utils/HttpRequestHandler";
import { BASE_URL } from "../utils/const";
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

	handleActivityDisplay() {
		this.http
			.get(`${BASE_URL}/activity`)
			.then((response) => {
				if (response.status === 200) {
					this.activity.openActivity(response);
				} else {
					throw Error("네트워크 에러가 발생했습니다. 새로고침 후 다시 시도해주세요.");
				}
			})
			.catch(handleError);
	}
}
