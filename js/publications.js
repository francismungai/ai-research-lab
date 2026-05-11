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

  // --- 2. SEARCH & FILTER LOGIC (RESEARCH PAPERS) ---
  const searchInput = document.getElementById("paper-search");
  const filterBtns = document.querySelectorAll(".filter-btn");
  const paperCards = document.querySelectorAll(".paper-card");
  const countDisplay = document.getElementById("paper-count");

  let currentFilter = "All";
  let searchQuery = "";

  function applyFilters() {
    let visibleCount = 0;

    paperCards.forEach((card) => {
      const cardText = card.textContent.toLowerCase();
      const matchesSearch = cardText.includes(searchQuery);
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

    if (countDisplay) {
      countDisplay.textContent = `Showing ${visibleCount} paper${visibleCount !== 1 ? "s" : ""}`;
    }
  }

  if (searchInput) {
    searchInput.addEventListener("input", (e) => {
      searchQuery = e.target.value.toLowerCase();
      applyFilters();
    });
  }

  filterBtns.forEach((btn) => {
    btn.addEventListener("click", (e) => {
      filterBtns.forEach((b) => {
        b.classList.remove("bg-[#C53030]", "text-white");
        b.classList.add("bg-gray-100", "text-gray-600");
      });

      const clickedBtn = e.target;
      clickedBtn.classList.remove("bg-gray-100", "text-gray-600");
      clickedBtn.classList.add("bg-[#C53030]", "text-white");

      currentFilter = clickedBtn.getAttribute("data-filter");
      applyFilters();
    });
  });

  applyFilters(); // Run once on load

  // --- 3. YEAR FILTER LOGIC (FEW SAMPLES) ---
  const yearBtns = document.querySelectorAll(".year-btn");
  const yearSections = document.querySelectorAll(".year-section");

  yearBtns.forEach((btn) => {
    btn.addEventListener("click", () => {
      // Update Active Pill
      yearBtns.forEach((b) => {
        b.classList.remove("bg-[#C53030]", "text-white");
        b.classList.add("bg-white", "text-gray-600");
      });
      btn.classList.remove("bg-white", "text-gray-600");
      btn.classList.add("bg-[#C53030]", "text-white");

      // Filter Sections
      const targetYear = btn.getAttribute("data-year");
      yearSections.forEach((section) => {
        if (
          targetYear === "All" ||
          section.getAttribute("data-year") === targetYear
        ) {
          section.style.display = "block";
        } else {
          section.style.display = "none";
        }
      });
    });
  });

  // --- 4. SCROLL BUTTONS LOGIC (THROTTLED) ---
  const scrollBtns = document.getElementById("scroll-buttons");
  let isScrolling = false;

  if (scrollBtns) {
    window.addEventListener("scroll", () => {
      if (!isScrolling) {
        window.requestAnimationFrame(() => {
          if (window.scrollY > 300) {
            scrollBtns.classList.replace("opacity-0", "opacity-100");
            scrollBtns.classList.replace(
              "pointer-events-none",
              "pointer-events-auto",
            );
          } else {
            scrollBtns.classList.replace("opacity-100", "opacity-0");
            scrollBtns.classList.replace(
              "pointer-events-auto",
              "pointer-events-none",
            );
          }
          isScrolling = false;
        });
        isScrolling = true;
      }
    });
  }
});
