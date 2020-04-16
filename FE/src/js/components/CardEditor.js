import { cardEditor } from "../utils/template";
import { ALERT_MESSAGE } from "../utils/const";

export default class CardEditor {
	$cardEditor = null;
	$title = null;
	$contents = null;
	$cancel = null;
	$save = null;

	constructor({ data, onSave }) {
		this.data = data;
		this.onSave = onSave;
		this.render();
		this.cacheDomElements();
		this.bindEventListener();
	}

	render() {
		document.getElementById("Todo").insertAdjacentHTML("afterend", cardEditor(this.data.contents));
	}

	cacheDomElements() {
		this.$cardEditor = document.querySelector(".card-editor");
		this.$title = this.$cardEditor.querySelector(".editor-title");
		this.$contents = this.$cardEditor.querySelector(".editor-contents");
		this.$cancel = this.$cardEditor.querySelector(".close-editor");
		this.$save = this.$cardEditor.querySelector(".save");
	}

	bindEventListener() {
		this.$contents.addEventListener("input", (e) => this.handleTextArea.call(this, e));
		this.$cancel.addEventListener("click", this.toggleDisplay.bind(this, { visible: false }));
		this.$save.addEventListener("click", () => this.handleUpdatingCard());
	}

	handleTextArea(e) {
		const value = e.target.value;
		const length = value.length;
		length !== 0 ? this.activateSaveButton() : this.deactivateSaveButton();
		if (length > 500) {
			e.target.value = value.substring(0, 500);
			alert(ALERT_MESSAGE.LIMIT_NUM_OF_CHAR);
		}
	}

	activateSaveButton() {
		this.$save.removeAttribute("disabled");
	}

	deactivateSaveButton() {
		this.$save.setAttribute("disabled", true);
	}

	handleUpdatingCard() {
		const newTitle = this.$title.value;
		const newContents = this.$contents.value;
		if (!newTitle) {
			alert(ALERT_MESSAGE.NO_TITLE);
			return;
		}
		this.onSave(newTitle, newContents);
		this.toggleDisplay({ visible: false });
	}

	toggleDisplay(nextData) {
		this.data = nextData;
		const {
			$cardEditor,
			data: { title, contents, visible },
		} = this;
		this.$cardEditor.querySelector(".editor-title").value = title;
		this.$cardEditor.querySelector(".editor-contents").value = contents;
		visible ? ($cardEditor.style.display = "block") : ($cardEditor.style.display = "none");
	}
}
