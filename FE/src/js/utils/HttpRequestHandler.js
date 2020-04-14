export default class HttpRequestHandler {
	get(url) {
		const options = {
			method: "GET",
			credentials: "include",
		};
		return this.getResponse(url, options);
	}

	post(url, data) {
		const options = {
			method: "POST",
			credentials: "include",
			headers: {
				"Content-type": "application/json",
			},
			body: JSON.stringify(data),
		};
		return this.getResponse(url, options);
	}

	async getResponse(url, options) {
		const response = await fetch(url, options);
		const resPromise = await response.json();
		return resPromise;
	}
}
