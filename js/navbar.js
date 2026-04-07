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

    // Skip the auth buttons so they retain their unique styling
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

  // --- 3. Auth State: Update navbar login/logout button ---
  updateNavbarAuth();
}

/**
 * Updates the navbar to show either "Log In" or the user email + "Log Out"
 * based on the current Supabase session.
 */
async function updateNavbarAuth() {
  // Only run if Supabase is available
  if (typeof supabaseClient === "undefined") return;

  try {
    const {
      data: { session },
    } = await supabaseClient.auth.getSession();

    // Desktop auth container
    const desktopAuthContainer = document.querySelector(
      ".hidden.md\\:block",
    );
    // Mobile auth link
    const mobileAuthLink = document.querySelector(
      '.mobile-menu-container a[href="login.html"]',
    );

    if (session && session.user) {
      const userEmail = session.user.email;
      const displayName =
        userEmail.length > 20
          ? userEmail.substring(0, 18) + "..."
          : userEmail;

      // Update desktop navbar
      if (desktopAuthContainer) {
        desktopAuthContainer.innerHTML = `
          <div class="flex items-center gap-2">
            <span class="text-white/80 text-[11px] font-medium hidden lg:inline truncate max-w-[120px]" title="${userEmail}">
              ${displayName}
            </span>
            <button id="logout-btn-desktop"
              class="bg-white text-[#C53030] px-3 py-1.5 rounded-md text-xs font-bold hover:bg-gray-100 transition shadow-sm cursor-pointer whitespace-nowrap">
              Log Out
            </button>
          </div>
        `;

        document
          .getElementById("logout-btn-desktop")
          ?.addEventListener("click", handleLogout);
      }

      // Update mobile navbar
      if (mobileAuthLink) {
        const mobileContainer = mobileAuthLink.parentElement;
        // Replace the login link with user info + logout
        mobileAuthLink.outerHTML = `
          <div class="px-3 py-2 text-white/80 text-sm font-medium truncate" title="${userEmail}">
            ${displayName}
          </div>
          <button id="logout-btn-mobile"
            class="text-white block w-full text-left px-3 py-2 rounded-md text-base font-bold bg-red-900 mt-1 cursor-pointer">
            Log Out
          </button>
        `;

        document
          .getElementById("logout-btn-mobile")
          ?.addEventListener("click", handleLogout);
      }
    }
    // If no session, the default "Log In" link remains as-is.
  } catch (err) {
    console.error("Error checking auth state:", err);
  }
}

/**
 * Handles user logout via Supabase.
 */
async function handleLogout() {
  try {
    const { error } = await supabaseClient.auth.signOut();
    if (error) {
      if (typeof showToast === "function")
        showToast("Error signing out: " + error.message, "error");
    } else {
      // Redirect to login page
      window.location.href = "login.html";
    }
  } catch (err) {
    console.error("Logout error:", err);
    window.location.href = "login.html";
  }
}
