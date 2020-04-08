import Header from "./Header";
import ColumnContainer from "./ColumnContainer";

export default class Todo {
	$target = null;
	data = null;

	constructor({ $target, data }) {
		this.$target = $target;
		this.data = data;

		this.header = new Header($target);
		this.columnContainer = new ColumnContainer({ $target, initialData: data.columns });
	}
}
