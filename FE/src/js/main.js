import "core-js/stable";
import "regenerator-runtime/runtime";
import "Scss/styles.scss";
import Todo from "./components/Todo";
import HttpRequestHandler from "./utils/HttpRequestHandler";
import { BASE_URL, USER_INFO } from "./utils/const";
import { handleError } from "./utils/utilFunction";

const http = new HttpRequestHandler();

const loadTodoModule = (response) => {
	const $target = document.querySelector("#Todo");
	new Todo({ $target, data: response });
};

const fetchTodoData = () => {
	http.get(`${BASE_URL}/columns`).then(loadTodoModule).catch(handleError);
};

const switchPage = () => {
	const $login = document.querySelector(".login-container");
	$login.remove();

	const $todo = document.createElement("div");
	$todo.id = "Todo";
	document.body.appendChild($todo);
};

const handleLoginResponse = (response) => {
	if (response.status === 200) {
		switchPage();
		fetchTodoData();
	} else {
		throw Error(`Network Error ─ ${code}`);
	}
};

const handleLogin = () => {
	http.post(`${BASE_URL}/login`, USER_INFO).then(handleLoginResponse).catch(handleError);
};

document.querySelector(".login").addEventListener("click", handleLogin);
