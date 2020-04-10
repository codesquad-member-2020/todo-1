import { cardEditor } from "../utils/template";

export default class CardEditor {
	$cardEditor = null;
	$cancel = null;
	$save = null;

	constructor({ data, onSave }) {
		this.data = data;
		this.onSave = onSave;
		this.render();
		this.cacheDomElements();
	}

	render() {
		document.getElementById("Todo").insertAdjacentHTML("afterend", cardEditor(this.data.content));
	}

	cacheDomElements() {
		this.$cardEditor = document.querySelector(".card-editor");
		this.$cancel = this.$cardEditor.querySelector(".close-editor");
		this.$save = this.$cardEditor.querySelector(".save");
	}
}
