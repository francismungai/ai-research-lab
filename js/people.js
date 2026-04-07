document.addEventListener("DOMContentLoaded", () => {
  // 1. Select the button containers based on the HTML structure we built
  const filtersContainer = document.querySelector(".mb-10.space-y-6");
  if (!filtersContainer) return;

  const roleButtons = filtersContainer.querySelectorAll(".flex-wrap button");
  const alphaButtons = filtersContainer.querySelectorAll(
    ".hide-scrollbar button",
  );
  const peopleCards = document.querySelectorAll(".grid > div.group"); // Selects all the people cards

  // 2. State variables
  let activeRole = "All";
  let activeLetter = "All";

  // 3. Helper Dictionary: Maps button names to keywords found in the card's <p> tag
  const roleKeywords = {
    Faculty: ["professor", "chair", "director", "faculty"],
    Postdoc: ["postdoc", "post-doctoral"],
    "PhD Students": ["phd"],
    "Masters Students": ["master"],
    Undergraduate: ["undergraduate", "bachelor", "bsc"],
    Alumni: ["alumni", "graduate", "former"],
  };

  // 4. The Core Filtering Function
  function filterPeople() {
    let visibleCount = 0;

    peopleCards.forEach((card) => {
      const nameEl = card.querySelector("h3");
      const roleEl = card.querySelector("p");

      if (!nameEl || !roleEl) return;

      // Clean the name (remove "Prof." or "Dr." so "Dr. John" counts as 'J', not 'D')
      let rawName = nameEl.textContent.trim();
      let cleanName = rawName.replace(/^(Prof\.|Dr\.)\s*/i, "").trim();
      let firstLetter = cleanName.charAt(0).toUpperCase();

      let roleText = roleEl.textContent.toLowerCase();

      // Check Role Match
      let matchesRole = false;
      if (activeRole === "All") {
        matchesRole = true;
      } else {
        const keywords = roleKeywords[activeRole] || [];
        matchesRole = keywords.some((keyword) => roleText.includes(keyword));
      }

      // Check Letter Match
      let matchesLetter = false;
      if (activeLetter === "All") {
        matchesLetter = true;
      } else {
        matchesLetter = firstLetter === activeLetter;
      }

      // Show or Hide
      if (matchesRole && matchesLetter) {
        card.style.display = "flex"; // Use flex to maintain the internal flex-col layout
        visibleCount++;
      } else {
        card.style.display = "none";
      }
    });

    // Update the pagination/count text at the bottom
    const countDisplay = document.querySelector(".tracking-wide");
    if (countDisplay) {
      countDisplay.textContent = `Showing ${visibleCount} ${visibleCount === 1 ? "person" : "people"}`;
    }
  }

  // 5. Button Click Handlers & Styling Logic
  function handleButtonClick(buttons, clickedBtn, isRoleFilter) {
    // Remove active styles from all buttons in this group
    buttons.forEach((btn) => {
      btn.classList.remove("bg-[#C53030]", "text-white", "border-[#C53030]");
      btn.classList.add("bg-gray-50", "text-gray-600", "border-gray-200");
    });

    // Add active styles to the clicked button
    clickedBtn.classList.remove(
      "bg-gray-50",
      "text-gray-600",
      "border-gray-200",
    );
    clickedBtn.classList.add("bg-[#C53030]", "text-white", "border-[#C53030]");

    // Update state and run filter
    if (isRoleFilter) {
      activeRole = clickedBtn.textContent.trim();
    } else {
      activeLetter = clickedBtn.textContent.trim();
    }

    filterPeople();
  }

  // Attach listeners to Role buttons
  roleButtons.forEach((btn) => {
    btn.addEventListener("click", (e) =>
      handleButtonClick(roleButtons, e.target, true),
    );
  });

  // Attach listeners to Alphabet buttons
  alphaButtons.forEach((btn) => {
    btn.addEventListener("click", (e) =>
      handleButtonClick(alphaButtons, e.target, false),
    );
  });

  // Initialize count on load
  filterPeople();
});
