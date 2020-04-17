export default class HttpRequestHandler {
	get(url: string) {
		const options = {
			method: "GET",
			credentials: "include",
		};
		return this.getResponse(url, options);
	}

	post(url: string, data: object) {
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

	put(url: string, data: object) {
		const options = {
			method: "PUT",
			credentials: "include",
			headers: {
				"Content-type": "application/json",
			},
			body: JSON.stringify(data),
		};
		return this.getResponse(url, options);
	}

	patch(url: string, data: object) {
		const options = {
			method: "PATCH",
			credentials: "include",
			headers: {
				"Content-type": "application/json",
			},
			body: JSON.stringify(data),
		};
		return this.getResponse(url, options);
	}

	delete(url: string) {
		const options = {
			method: "DELETE",
			credentials: "include",
		};
		return this.getResponse(url, options);
	}

	async getResponse(url: string, options: object) {
		const response = await fetch(url, options);
		const resPromise = await response.json();
		return resPromise;
	}
}
