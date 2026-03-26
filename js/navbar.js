/**
 * Navbar Initialization Logic
 * Runs strictly after the loader has injected the navbar HTML.
 */
function initNavbar() {
  // --- 1. Mobile Menu Toggle Logic ---
  const menuBtn = document.querySelector(".md\\:hidden button");
  const mobileMenu = document.querySelector(".mobile-menu-container");

  if (menuBtn && mobileMenu) {
    menuBtn.addEventListener("click", () => {
      mobileMenu.classList.toggle("hidden");
    });
  }

  // --- 2. Active Link Highlight Logic ---
  // Get current filename (e.g., "people.html")
  let currentPath = window.location.pathname.split("/").pop();

  // Default to index.html if user is at the root domain
  if (currentPath === "" || currentPath === "/") {
    currentPath = "index.html";
  }

  // Target both desktop and mobile menu links
  const navLinks = document.querySelectorAll(
    ".space-x-6 a, .mobile-menu-container a",
  );

  navLinks.forEach((link) => {
    const href = link.getAttribute("href");

    // Skip the Log In button so it retains its unique styling
    if (href === "login.html") return;

    // Apply active styles if the href matches the current URL
    if (href === currentPath) {
      link.classList.remove("hover:text-gray-200", "hover:bg-red-800");
      link.classList.add(
        "bg-red-900",
        "text-white",
        "rounded-md",
        "shadow-inner",
      );
    }
  });
}
