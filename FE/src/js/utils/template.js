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
						<i class="fas fa-plus"></i>
						<i class="fas fa-ellipsis-h"></i>
					</div>
        </div>`;
	const columnBody = `<div class="column__body"></div>`;
	return `<div class="column">${columnHeader}${columnBody}</div>`;
}

export function card({ contents }) {
	return `<div class="card">
						<i class="far fa-sticky-note"></i>
						<span class="content">${contents}</span>
						<i class="fas fa-times"></i>
					</div>`;
}

export function cardCreator() {
	return `<div class="card-creator">
            <textarea class="card-textarea" placeholder="Enter a note"></textarea>
            <div class="card-creator__buttons">
              <button type="button" class="add" disabled>Add</button>
              <button type="button" class="cancel">Cancel</button>
            </div>
          </div>`;
}
