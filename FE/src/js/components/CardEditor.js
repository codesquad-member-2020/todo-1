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
		document.getElementById("Todo").insertAdjacentHTML("afterend", cardEditor(this.data.contents));
	}

	cacheDomElements() {
		this.$cardEditor = document.querySelector(".card-editor");
		this.$cancel = this.$cardEditor.querySelector(".close-editor");
		this.$save = this.$cardEditor.querySelector(".save");
	}

	toggleDisplay(nextData) {
		this.data = nextData;
		const {
			$cardEditor,
			data: { contents, visible },
		} = this;
		this.$cardEditor.querySelector(".editor-contents").textContent = contents;
		visible ? ($cardEditor.style.display = "block") : ($cardEditor.style.display = "none");
	}
}
