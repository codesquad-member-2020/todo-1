import "core-js/stable";
import "regenerator-runtime/runtime";
import "Scss/styles.scss";

const replacePage = () => location.replace("todo.html");
document.querySelector(".login").addEventListener("click", replacePage);
