import "core-js/stable";
import "regenerator-runtime/runtime";
import "Scss/styles.scss";
import Todo from "./components/Todo";
import HttpRequestHandler from "./utils/HttpRequestHandler";
import { BASE_URL } from "./utils/const";
import { handleError } from "./utils/utilFunction";

const http = new HttpRequestHandler();

const loadTodoModule = (response) => {
	const $target = document.querySelector("#Todo");
	new Todo({ $target, data: response });
};

const fetchTodoData = () => {
	http.get(`${BASE_URL}/columns`).then(loadTodoModule).catch(handleError);
};

fetchTodoData();
