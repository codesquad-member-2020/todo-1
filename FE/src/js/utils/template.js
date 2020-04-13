export function header() {
	return `<header>
		<div class="header-container">
			<h1>Todo List</h1>
			<div class="menu">
				<i class="fas fa-bars"></i>
			</div>
		</div>
	</header>`;
}

export function columnContainer() {
	return `<main>
		<div class="columns-container">
      <div class="columns"></div>
    </div>
  </main>`;
}

export function column({ id, columnName, cards }) {
	const columnHeader = `<div class="column__header">
					<div>
						<span class="column__counter">${cards.length}</span>
						<h3 class="column__name">${columnName}</h3>
					</div>
					<div>
						<i class="fas fa-plus add-card"></i>
						<i class="fas fa-ellipsis-h"></i>
					</div>
        </div>`;
	const columnBody = `<div class="column__body"><div class="card-container"></div></div>`;
	return `<div class="column" data-id="${id}">${columnHeader}${columnBody}</div>`;
}

export function card({ id, title, contents, userId }) {
	return `<div class="card" data-id="${id}" draggable="true">
            <div class="card-wrapper">
              <div class="title"><i class="far fa-sticky-note"></i>${title}</div>
              <div class="contents">${contents}</div>
              <div class="user-info">Added by <span class="user-id">${userId}</span></div>
            </div>
						<i class="fas fa-times delete-card"></i>
					</div>`;
}

export function cardCreator() {
	return `<div class="card-creator" style="display:none;">
            <input class="card-title" placeholder="Title">
            <textarea class="card-textarea" placeholder="Enter a note"></textarea>
            <div class="card-creator__buttons">
              <button type="button" class="add" disabled>Add</button>
              <button type="button" class="cancel">Cancel</button>
          </div>`;
}

export function alert(message) {
	return `<div class="alert" style="display:none;">
		<div class="alert__message">${message}</div>
		<div class="alert__buttons">
			<button class="cancel">Cancel</button>
			<button class="confirm">Confirm</button>
		</div>
	</div>`;
}

export function cardEditor(contents) {
	return `<div class="card-editor" style="display:none;">
			<div class="editor-container">
				<div class="editor-header">
					<span class="title">Edit note</span>
					<i class="fas fa-times close-editor"></i>
				</div>
        <span class="sub-title">note</span>
        <input class="editor-title" placeholder="Title">
				<textarea class="editor-contents" placeholder="Enter a note">${contents}</textarea>
				<button class="save">Save note</button>
			</div>
		</div>`;
}

const actions = {
	add: (userId, profileURL, title, toColumn) => `
    <li class="detail-container">
      <img src="${profileURL}" alt="@${userId}" />
      <p class="detail">
        <span class="detail__data">@${userId}</span> <span class="action">added</span>
        <span class="detail__data">${title}</span> to <strong>${toColumn}</strong
        ><span class="time">1 day ago</span>
      </p>
    </li>
  `,
	remove: (userId, profileURL, title) => `
    <li class="detail-container">
      <img src="${profileURL}" alt="@${userId}" />
      <p class="detail">
        <span class="detail__data">@${userId}</span> <span class="action">removed</span>
        <span class="detail__data">${title}</span
        ><span class="time">1 day ago</span>
      </p>
    </li>
  `,
	update: (userId, profileURL, title) => `
    <li class="detail-container">
      <img src="${profileURL}" alt="@${userId}" />
      <p class="detail">
        <span class="detail__data">@${userId}</span> <span class="action">updated</span>
        <span class="detail__data">${title}</span
        ><span class="time">1 day ago</span>
      </p>
    </li>
  `,
	move: (userId, profileURL, title, fromColumn, toColumn) => `
    <li class="detail-container">
      <img src="${profileURL}" alt="@${userId}" />
      <p class="detail">
        <span class="detail__data">@${userId}</span> <span>moved</span>
        <span class="detail__data">${title}</span> from
        <strong>${fromColumn}</strong> to <strong>${toColumn}</strong
        ><span class="time">1 day ago</span>
      </p>
    </li>
  `,
};

export function activity(data) {
	return `<div class="activity">
			<div>
				<div class="activity-border top">
					<h3><i class="fas fa-bars"></i>Menu</h3>
					<i class="fas fa-times close-activity"></i>
				</div>
				<div class="activity-border">
					<h3><i class="fas fa-bell"></i>Activity</h3>
				</div>
				<div class="activity-detail">
					<ul>
						${data.reduce((list, { userId, profileURL, action, title, fromColumn, toColumn, actionTime }) => {
							list += actions[action](userId, profileURL, title, fromColumn, toColumn);
							return list;
						}, "")}
					</ul>
				</div>
			</div>
		</div>`;
}
