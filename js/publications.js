document.addEventListener("DOMContentLoaded", () => {
  // --- 1. TAB SWITCHING LOGIC ---
  const btnSamples = document.getElementById("tab-btn-samples");
  const btnPapers = document.getElementById("tab-btn-papers");
  const contentSamples = document.getElementById("tab-content-samples");
  const contentPapers = document.getElementById("tab-content-papers");

  const activeTabClasses = ["border-[#C53030]", "text-[#C53030]"];
  const inactiveTabClasses = [
    "border-transparent",
    "text-gray-500",
    "hover:text-gray-800",
    "hover:border-gray-300",
  ];

  function switchTab(isSamples) {
    if (isSamples) {
      contentSamples.classList.remove("hidden");
      contentPapers.classList.add("hidden");
      btnSamples.classList.add(...activeTabClasses);
      btnSamples.classList.remove(...inactiveTabClasses);
      btnPapers.classList.add(...inactiveTabClasses);
      btnPapers.classList.remove(...activeTabClasses);
    } else {
      contentSamples.classList.add("hidden");
      contentPapers.classList.remove("hidden");
      btnPapers.classList.add(...activeTabClasses);
      btnPapers.classList.remove(...inactiveTabClasses);
      btnSamples.classList.add(...inactiveTabClasses);
      btnSamples.classList.remove(...activeTabClasses);
    }
  }

  if (btnSamples && btnPapers) {
    btnSamples.addEventListener("click", () => switchTab(true));
    btnPapers.addEventListener("click", () => switchTab(false));
  }

  // --- 2. SEARCH & FILTER LOGIC ---
  const searchInput = document.getElementById("paper-search");
  const filterBtns = document.querySelectorAll(".filter-btn");
  const paperCards = document.querySelectorAll(".paper-card");
  const countDisplay = document.getElementById("paper-count");

  let currentFilter = "All";
  let searchQuery = "";

  // The function that does the actual filtering
  function applyFilters() {
    let visibleCount = 0;

    paperCards.forEach((card) => {
      // Get all text inside the card and convert to lowercase for easy matching
      const cardText = card.textContent.toLowerCase();

      // Check if it matches the search bar
      const matchesSearch = cardText.includes(searchQuery);

      // Check if it matches the active pill (or if 'All' is selected)
      const matchesFilter =
        currentFilter === "All" ||
        cardText.includes(currentFilter.toLowerCase());

      if (matchesSearch && matchesFilter) {
        card.style.display = "block";
        visibleCount++;
      } else {
        card.style.display = "none";
      }
    });

    // Update the tiny text telling the user how many papers are shown
    if (countDisplay) {
      countDisplay.textContent = `Showing ${visibleCount} paper${visibleCount !== 1 ? "s" : ""}`;
    }
  }

  // Listen for typing in the search bar
  if (searchInput) {
    searchInput.addEventListener("input", (e) => {
      searchQuery = e.target.value.toLowerCase();
      applyFilters();
    });
  }

  // Listen for clicks on the filter pills
  filterBtns.forEach((btn) => {
    btn.addEventListener("click", (e) => {
      // Remove 'active' styling from all buttons
      filterBtns.forEach((b) => {
        b.classList.remove("bg-[#C53030]", "text-white");
        b.classList.add("bg-gray-100", "text-gray-600");
      });

      // Add 'active' styling to the clicked button
      const clickedBtn = e.target;
      clickedBtn.classList.remove("bg-gray-100", "text-gray-600");
      clickedBtn.classList.add("bg-[#C53030]", "text-white");

      // Update state and filter
      currentFilter = clickedBtn.getAttribute("data-filter");
      applyFilters();
    });
  });

  // Run once on load to set the initial count
  applyFilters();
});
