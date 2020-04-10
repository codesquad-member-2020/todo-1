import "core-js/stable";
import "regenerator-runtime/runtime";
import "Scss/styles.scss";
import data from "./data";
import Todo from "./components/Todo";

const $target = document.querySelector("#Todo");

new Todo({ $target, data });
