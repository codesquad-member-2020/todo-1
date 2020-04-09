export default {
	columns: [
		{
			columnName: "todo",
			id: 1,
			index: 0,
			cards: [
				{
					id: "1",
					userId: "sunny",
					title: "hello world!! this is title / row : 0",
					contents: null,
					device: "web",
					row: 0,
				},
				{
					id: "2",
					userId: "honux",
					title: "node.js 공부하기 / row : 1",
					contents: "this is contents!",
					device: "ios",
					row: 1,
				},
			],
		},
		{
			columnName: "In Progress",
			id: 2,
			index: 1,
			cards: [
				{
					id: "1",
					userId: "sunny",
					title: "hello world!! this is title  / row : 0",
					contents: null,
					device: "web",
					row: 0,
				},
				{
					id: "2",
					userId: "honux",
					title: "node.js 공부하기  / row : 1",
					contents: "this is contents!",
					device: "ios",
					row: 1,
				},
			],
		},
		{
			columnName: "Done",
			id: 3,
			index: 2,
			cards: [],
		},
	],
};
