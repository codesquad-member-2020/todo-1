import { column } from "../utils/template";
import data from "../data";
import Card from "./Card";
import CardCreator from "./CardCreator";
import HttpRequestHandler from "../utils/HttpRequestHandler";
import { BASE_URL } from "../utils/const";
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
			cards.forEach((card) => new Card({ $target: this, data: card }));
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

	addCard(value) {
		const newCardObj = this.createCardObj(value);
		this.http
			.post(`${BASE_URL}/columns/${this.id}/cards`, newCardObj)
			.then((response) => {
				new Card({ $target: this, data: response });
				this.handleCounter("up");
				console.log("card added!");
			})
			.catch(handleError);
	}

	deleteCard({ $card, id }) {
		this.http
			.delete(`${BASE_URL}/columns/${this.id}/cards/${id}`)
			.then((response) => {
				if (response.status === 200) {
					this.$cardContainer.removeChild($card);
					this.handleCounter("down");
					console.log("card deleted!");
				}
			})
			.catch(handleError);
	}

	updateCard({ $card, id, data }) {
		const newCardObj = this.createCardObj(data);
		this.http
			.put(`${BASE_URL}/columns/${this.id}/cards/${id}`, newCardObj)
			.then((response) => {
				if (response.status === 200) {
					$card.querySelector(".title").textContent = response.card.title;
					$card.querySelector(".contents").textContent = response.card.contents;
					console.log("card updated!");
				}
			})
			.catch(handleError);
	}

	moveCard({ cardId, fromColumnId, toColumnId, toRow }) {
		// send data to the server
		console.log("------------------------------");
		console.log("cardId : ", cardId);
		console.log("fromColumn : ", fromColumnId);
		console.log("toColumn : ", toColumnId);
		console.log("toRow : ", toRow);
		console.log("------------------------------");
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
				console.error("카운터 인자가 전달되지 않았습니다.");
				return;
		}
	}
}
