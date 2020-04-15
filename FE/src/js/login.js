import "core-js/stable";
import "regenerator-runtime/runtime";
import "Scss/styles.scss";
import HttpRequestHandler from "./utils/HttpRequestHandler";
import { BASE_URL, USER_INFO } from "./utils/const";
import { handleError } from "./utils/utilFunction";

const http = new HttpRequestHandler();

const handleLoginResponse = (response) => {
	if (response.status === 200) {
		location.replace("todo.html");
	} else {
		throw Error(`Network Error ─ ${code}`);
	}
};

const handleLogin = () => {
	http.post(`${BASE_URL}/login`, USER_INFO).then(handleLoginResponse).catch(handleError);
};

document.querySelector(".login").addEventListener("click", handleLogin);
