import { column } from "../utils/template";
import Card from "./Card";
import CardCreator from "./CardCreator";
import HttpRequestHandler from "../utils/HttpRequestHandler";
import { BASE_URL, NETWORK_MESSAGE, CONSOLE_MESSAGE } from "../utils/const";
import { handleError } from "../utils/utilFunction";

export default class Column {
	$column = null;
	$columnHeader = null;
	$columnBody = null;
	$cardContainer = null;
	$counter = null;
	cardCreatorIsShowing = false;

	http = new HttpRequestHandler();

	constructor({ $target, initialData, index }) {
		this.$target = $target;
		this.initialData = initialData;
		this.id = initialData.id;
		this.index = index;

		this.render();
		this.cacheDomElements();
		this.bindEventListener();

		this.renderCards();

		this.cardCreator = new CardCreator({
			$target: this,
			data: {
				visible: false,
			},
			onSave: this.addCard.bind(this),
		});
	}

	render() {
		this.$target.insertAdjacentHTML("beforeend", column(this.initialData));
	}

	cacheDomElements() {
		this.$column = [...this.$target.children][this.index];
		this.$columnHeader = this.$column.querySelector(".column__header");
		this.$columnBody = this.$column.querySelector(".column__body");
		this.$cardContainer = this.$column.querySelector(".card-container");
		this.$counter = this.$columnHeader.querySelector(".column__counter");
	}

	bindEventListener() {
		const addCardButton = this.$columnHeader.querySelector(".add-card");
		addCardButton.addEventListener("click", this.handleCardCreator.bind(this));
	}

	renderCards() {
		const {
			initialData: { cards },
		} = this;
		if (cards.length !== 0) {
			cards.reverse().forEach((card) => new Card({ $target: this, data: card }));
		}
	}

	handleCardCreator() {
		if (!this.cardCreatorIsShowing) {
			this.cardCreator.toggleDisplay({ visible: true });
			this.cardCreatorIsShowing = true;
		} else {
			this.cardCreator.toggleDisplay({ visible: false });
			this.cardCreatorIsShowing = false;
		}
	}

	createCardObj({ title, contents }) {
		return {
			userId: "reese",
			title: title,
			contents: contents,
			device: "web",
		};
	}

	async addCard(value) {
		const newCardObj = this.createCardObj(value);
		try {
			const response = await this.http.post(`${BASE_URL}/columns/${this.id}/cards`, newCardObj);
			if (response.status === 200) {
				new Card({ $target: this, data: response.card });
				this.handleCounter("up");
			}
		} catch (err) {
			handleError(err);
		}
	}

	async deleteCard({ $card, id }) {
		try {
			const response = await this.http.delete(`${BASE_URL}/columns/${this.id}/cards/${id}`);
			if (response.status === 200 || response.status === 204) {
				this.$cardContainer.removeChild($card);
				this.handleCounter("down");
			}
		} catch (err) {
			handleError(err);
		}
	}

	async updateCard({ $card, id, data }) {
		const newCardObj = this.createCardObj(data);
		try {
			const response = await this.http.put(
				`${BASE_URL}/columns/${this.id}/cards/${id}`,
				newCardObj
			);

			if (response.status === 200) {
				$card.querySelector(".title").textContent = response.card.title;
				$card.querySelector(".contents").textContent = response.card.contents;
				return;
			}
			if (response.status === 204) {
				this.deleteCard({ $card, id });
				throw Error(NETWORK_MESSAGE.ALREADY_DELETED);
			}
		} catch (err) {
			handleError(err);
		}
	}

	async moveCard({ cardId, fromColumnId, toColumnId, toRow }) {
		const data = {
			toColumn: toColumnId,
			toRow: toRow,
		};

		try {
			const response = await this.http.post(
				`${BASE_URL}/columns/${fromColumnId}/cards/${cardId}`,
				data
			);
			if (response.status === 204) {
				this.deleteCard({ $card, id });
				throw Error(NETWORK_MESSAGE.ALREADY_DELETED);
			}
			if (response.status !== 200) {
				throw Error(NETWORK_MESSAGE.NETWORK_ERROR);
			}
		} catch (err) {
			handleError(err);
		}
	}

	handleCounter(state) {
		switch (state) {
			case "up":
				this.$counter.textContent = Number(this.$counter.textContent) + 1;
				break;
			case "down":
				this.$counter.textContent = Number(this.$counter.textContent) - 1;
				break;
			default:
				console.error(CONSOLE_MESSAGE.NO_PROPER_ARGUMENTS);
				return;
		}
	}
}
