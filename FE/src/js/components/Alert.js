import { alert } from "../utils/template";

export default class Alert {
	$alert = null;

	constructor({ data, onConfirm }) {
		this.data = data;
		this.onConfirm = onConfirm;

		this.render();
	}

	render() {
		document.getElementById("Todo").insertAdjacentHTML("afterend", alert(this.data.message));
		this.$alert = document.querySelector(".alert");
	}

	toggleDisplay(nextData) {
		this.data = nextData;
		const {
			$alert,
			data: { visible },
		} = this;
		visible ? ($alert.style.display = "block") : ($alert.style.display = "none");
	}
}
