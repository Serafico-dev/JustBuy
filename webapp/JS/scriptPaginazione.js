document.addEventListener('DOMContentLoaded', function () {
	const content = document.querySelector('.paginaRisultati');
	const itemsPerPage = 16; // set number of items per page
	let currentPage = 0;
	const items = Array.from(content.getElementsByTagName('section')).slice(0); // tag name set to section and slice set to 0

	function showPage(page) {
		const startIndex = page * itemsPerPage;
		const endIndex = startIndex + itemsPerPage;
		items.forEach((item, index) => {
			item.classList.toggle('hidden', index < startIndex || index >= endIndex);
		});
		updateActiveButtonStates();
	}

	function createPageButtons() {
		const totalPages = Math.ceil(items.length / itemsPerPage);
		const paginationContainer = document.createElement('div');
		const paginationDiv = document.body.appendChild(paginationContainer);
		paginationContainer.classList.add('pagination');

		// Add page buttons
		for (let i = 0; i < totalPages; i++) {
			const pageButton = document.createElement('button');
			pageButton.textContent = i + 1;
			pageButton.addEventListener('click', () => {
				currentPage = i;
				showPage(currentPage);
				updateActiveButtonStates();
				// TODO: AGGIUNTO SCROLL TO TOP
				document.body.scrollTop = 0;
				document.documentElement.scrollTop = 0;
			});

			content.appendChild(paginationContainer);
			paginationDiv.appendChild(pageButton);
		}
	}

	function updateActiveButtonStates() {
		const pageButtons = document.querySelectorAll('.pagination button');
		pageButtons.forEach((button, index) => {
			button.classList.add('submitInput')
			button.classList.add('px-2')
			button.classList.add('mx-1')
			button.classList.add('mb-5')
			if (index === currentPage) {
				button.classList.add('active');
			} else {
				button.classList.remove('active');
			}
		});
	}

	createPageButtons(); // Call this function to create the page buttons initially
	showPage(currentPage);
});