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

export function column(columnName, numOfCards) {
	const columnHeader = `<div class="column__header">
					<div>
						<span class="column__counter">${numOfCards}</span>
						<h3 class="column__name">${columnName}</h3>
					</div>
					<div>
						<i class="fas fa-plus add-card"></i>
						<i class="fas fa-ellipsis-h"></i>
					</div>
        </div>`;
	const columnBody = `<div class="column__body"><div class="card-container"></div></div>`;
	return `<div class="column">${columnHeader}${columnBody}</div>`;
}

export function card({ title, id }) {
	return `<div class="card" data-id="${id}">
						<i class="far fa-sticky-note"></i>
						<span class="content">${title}</span>
						<i class="fas fa-times delete-card"></i>
					</div>`;
}

export function cardCreator() {
	return `<div class="card-creator" style="display:none;">
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