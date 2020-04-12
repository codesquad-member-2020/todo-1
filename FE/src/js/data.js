export default {
	columns: [
		{
			id: 1,
			columnName: "Todo",
			cards: [
				{
					id: "1",
					userId: "sunny",
					title: "hello world!! this is title / row : 0 / lllooonnnnggggtitle~~~~",
					contents:
						"새로운 할 일(note)을 입력할 수 있다. 입력창에 placeholder가 있다. 입력창에 글자를 입력하면 Add 버튼이 활성화된다. 입력창에 글자가 길어지면 입력창 오른쪽에 스크롤이 생긴다. 입력창에 글자를 작성하다 전부 지우면 다시 placeholder가 나타나고 Add 버튼도 다시 비활성화된다. 입력창은 우측하단에 그립을 잡아서 세로로 늘리고 줄일 수 있다. 글자 수 제한은 500자이다. 할 일을 입력하고 Add 버튼을 클릭하면 하단에 4번과 같이 할 일 카드가 추가된다. 할 일이 추가되면 2번 영역은 다시 초기화(입력창에 텍스트 지워지고 placeholder 생김 + Add 버튼 비활성화)된다. Cancel 버튼을 클릭하면 2번 영역이 사라진다.",
					device: "web",
				},
				{
					id: "2",
					userId: "honux",
					title: "node.js 공부하기 / row : 1",
					contents: "this is contents!",
					device: "ios",
				},
			],
		},
		{
			id: 2,
			columnName: "In Progress",
			cards: [
				{
					id: "3",
					userId: "sunny",
					title: "hello world!! this is title  / row : 0",
					contents: "contents~~",
					device: "web",
				},
				{
					id: "4",
					userId: "honux",
					title: "node.js 공부하기  / row : 1",
					contents: "this is contents!",
					device: "ios",
				},
			],
		},
		{
			id: 3,
			columnName: "Done",
			cards: [],
		},
	],
};
