import "core-js/stable";
import "regenerator-runtime/runtime";
import "Scss/styles.scss";
import data from "./data";

const replacePage = () => location.replace("todo.html");

const showAlert = () => alert("Oopsy! Something went wrong.");

const handleLogin = () => {
	// http.post
	// 응답 받으면 데이터를 data.column에 할당
	// todo.js가 import해서 사용
	data.columns ? replacePage() : showAlert();
};

document.querySelector(".login").addEventListener("click", handleLogin);
