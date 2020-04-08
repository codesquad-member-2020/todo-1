console.log("Todo is running!");

export default class Todo {
	$target = null;
	data = [];

	constructor($target) {
		this.$target = $target;
		console.log(this.$target);
	}
}
