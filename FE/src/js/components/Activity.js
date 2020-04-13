import { activity } from "../utils/template";
import activityData from "../activityData";

export default class Header {
	constructor($target) {
		this.$target = $target;
		this.render();
	}

	render() {
		this.$target.insertAdjacentHTML("beforeend", activity(activityData));
	}
}
