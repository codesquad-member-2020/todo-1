export function header(): string {
	return `<header>
		<div class="header-container">
			<h1>Todo List</h1>
			<div class="menu">
				<i class="fas fa-bars"></i>
			</div>
		</div>
	</header>`;
}

export function columnContainer(): string {
	return `<main>
		<div class="columns-container">
      <div class="columns"></div>
    </div>
  </main>`;
}

interface ColumnParams {
	id: string;
	columnName: string;
	cards: object[];
}

export function column({ id, columnName, cards }: ColumnParams): string {
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

interface CardParams {
	id: string;
	title: string;
	contents: string;
	userId: string;
}

export function card({ id, title, contents, userId }: CardParams): string {
	return `<div class="card" data-id="${id}" draggable="true">
            <div class="card-wrapper">
              <div class="title"><i class="far fa-sticky-note"></i>${title}</div>
              <div class="contents">${contents}</div>
              <div class="user-info">Added by <span class="user-id">${userId}</span></div>
            </div>
						<i class="fas fa-times delete-card"></i>
					</div>`;
}

export function cardCreator(): string {
	return `<div class="card-creator" style="display:none;">
            <input class="card-title" placeholder="Title">
            <textarea class="card-textarea" placeholder="Enter a note"></textarea>
            <div class="card-creator__buttons">
              <button type="button" class="add" disabled>Add</button>
              <button type="button" class="cancel">Cancel</button>
          </div>`;
}

export function alert(message: string): string {
	return `<div class="alert" style="display:none;">
		<div class="alert__message">${message}</div>
		<div class="alert__buttons">
			<button class="cancel">Cancel</button>
			<button class="confirm">Confirm</button>
		</div>
	</div>`;
}

export function cardEditor(contents: string): string {
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

export function activity(): string {
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
				</div>
			</div>
		</div>`;
}

interface ActionParams {
	userId: string;
	profileURL: string;
	action: string;
	title: string;
	fromColumn: string;
	toColumn: string;
	actionTime: string;
}

const actions = {
	add: ({ userId, profileURL, title, toColumn, actionTime }: ActionParams): string => `
    <li class="detail-container">
      <img src="${profileURL}" alt="@${userId}" />
      <p class="detail">
        <span class="detail__data">@${userId}</span> <span class="action">added</span>
        <span class="detail__data">${title}</span> to <strong>${toColumn}</strong
        ><span class="time">${relativeTime(actionTime)} ago</span>
      </p>
    </li>
  `,
	remove: ({ userId, profileURL, title, actionTime }: ActionParams): string => `
    <li class="detail-container">
      <img src="${profileURL}" alt="@${userId}" />
      <p class="detail">
        <span class="detail__data">@${userId}</span> <span class="action">removed</span>
        <span class="detail__data">${title}</span
        ><span class="time">${relativeTime(actionTime)} ago</span>
      </p>
    </li>
  `,
	update: ({ userId, profileURL, title, actionTime }: ActionParams): string => `
    <li class="detail-container">
      <img src="${profileURL}" alt="@${userId}" />
      <p class="detail">
        <span class="detail__data">@${userId}</span> <span class="action">updated</span>
        <span class="detail__data">${title}</span
        ><span class="time">${relativeTime(actionTime)} ago</span>
      </p>
    </li>
  `,
	move: ({ userId, profileURL, title, fromColumn, toColumn, actionTime }: ActionParams): string => `
    <li class="detail-container">
      <img src="${profileURL}" alt="@${userId}" />
      <p class="detail">
        <span class="detail__data">@${userId}</span> <span>moved</span>
        <span class="detail__data">${title}</span> from
        <strong>${fromColumn}</strong> to <strong>${toColumn}</strong
        ><span class="time">${relativeTime(actionTime)} ago</span>
      </p>
    </li>
  `,
};

export function activityList(data: any): string {
	if (data.length === 0) return "";
	return `<ul>
						${data.reduce(
							(
								list: string,
								{
									userId,
									profileURL,
									action,
									title,
									fromColumn,
									toColumn,
									actionTime,
								}: ActionParams
							) => {
								list += actions[action]({
									userId,
									profileURL,
									title,
									fromColumn,
									toColumn,
									actionTime,
								});
								return list;
							},
							""
						)}
					</ul>`;
}

export function relativeTime(actionTime: string): string {
	const currDate = new Date();
	const diffMs = currDate.getTime() - new Date(actionTime).getTime();

	const second = diffMs / 1000;
	if (second < 60) return parseInt(second.toString()) + " second" + (second > 1 ? "s" : "");

	const minute = second / 60;
	if (minute < 60) return parseInt(minute.toString()) + " minute" + (minute > 1 ? "s" : "");

	const hour = minute / 60;
	if (hour < 24) return parseInt(hour.toString()) + " hour" + (hour > 1 ? "s" : "");

	const day = hour / 24;
	if (day < 30) return parseInt(day.toString()) + " day" + (day > 1 ? "s" : "");

	const month = day / 30;
	if (month < 12) return parseInt(month.toString()) + " month" + (month > 1 ? "s" : "");

	const year = month / 12;
	return parseInt(year.toString()) + " year" + (year > 1 ? "s" : "");
}

export function columnCreator(): string {
	return `<div class="column-add">
            <div><i class="fas fa-plus"></i>Add column</div>
          </div>`;
}
