import "core-js/stable";
import "regenerator-runtime/runtime";
import "Scss/styles.scss";
import HttpRequestHandler from "./utils/HttpRequestHandler";
import { BASE_URL, USER_INFO } from "./utils/const";
import { handleError } from "./utils/utilFunction";

const handleResponse = (response) => {
	if (response.status === 200) {
		location.replace("todo.html");
	} else {
		throw Error(`Network Error ─ ${code}`);
	}
};

const handleLogin = () => {
	const http = new HttpRequestHandler();
	const url = `${BASE_URL}/login`;
	http.post(url, USER_INFO).then(handleResponse).catch(handleError);
};

document.querySelector(".login").addEventListener("click", handleLogin);
