import { cardCreator } from "../utils/template";

export default class CardCreator {
	$cardCreator = null;

	constructor({ $target, data }) {
		this.$target = $target;
		this.data = data;
		this.render();
		this.cacheDomElements();
	}

	render() {
		this.$target.insertAdjacentHTML("afterbegin", cardCreator());
	}

	cacheDomElements() {
		this.$cardCreator = this.$target.querySelector(".card-creator");
	}

	toggleDisplay(nextData) {
		this.data = nextData;
		const {
			$cardCreator,
			data: { visible },
		} = this;
		visible ? ($cardCreator.style.display = "block") : ($cardCreator.style.display = "none");
	}
}
