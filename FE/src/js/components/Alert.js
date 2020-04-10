import { alert } from "../utils/template";

export default class Alert {
	$alert = null;
	$cancel = null;
	$confirm = null;

	constructor({ data, onConfirm }) {
		this.data = data;
		this.onConfirm = onConfirm;
		this.render();
		this.cacheDomElements();
		this.bindEventListener();
	}

	render() {
		document.getElementById("Todo").insertAdjacentHTML("afterend", alert(this.data.message));
	}

	cacheDomElements() {
		this.$alert = document.querySelector(".alert");
		this.$cancel = this.$alert.querySelector(".cancel");
		this.$confirm = this.$alert.querySelector(".confirm");
	}

	bindEventListener() {
		this.$cancel.addEventListener("click", this.toggleDisplay.bind(this, { visible: false }));
		this.$confirm.addEventListener("click", () => this.handleDeletingCard());
	}

	handleDeletingCard() {
		this.onConfirm();
		this.toggleDisplay({ visible: false });
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
