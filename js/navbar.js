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
  let currentPath = window.location.pathname.split("/").pop();

  if (currentPath === "" || currentPath === "/") {
    currentPath = "index.html";
  }

  const navLinks = document.querySelectorAll(
    ".space-x-6 a, .mobile-menu-container a",
  );

  navLinks.forEach((link) => {
    const href = link.getAttribute("href");

    if (href === "login.html") return;

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

  // --- 3. Auth State: Update navbar login/logout ---
  updateNavbarAuth();
}

/**
 * Updates the navbar to show a Dropdown for Dashboard and Log Out
 * if an active Supabase session exists.
 */
async function updateNavbarAuth() {
  if (typeof supabaseClient === "undefined") return;

  try {
    const {
      data: { session },
    } = await supabaseClient.auth.getSession();

    const desktopAuthContainer = document.querySelector(".hidden.md\\:block");
    const mobileAuthLink = document.querySelector(
      '.mobile-menu-container a[href="login.html"]',
    );

    if (session && session.user) {
      const userEmail = session.user.email;
      const displayName = userEmail.split("@")[0]; // Grabs just the name part before the @

      // --- Update Desktop Navbar (Dropdown Menu) ---
      if (desktopAuthContainer) {
        desktopAuthContainer.innerHTML = `
          <div class="relative inline-block text-left" id="user-menu-container">
            <button id="user-menu-button" class="flex items-center gap-2 bg-white text-[#C53030] px-4 py-2 rounded-md text-sm font-bold hover:bg-gray-100 transition shadow-sm focus:outline-none">
              <i class='bx bx-user-circle text-lg'></i>
              <span class="max-w-[100px] truncate">${displayName}</span>
              <i class='bx bx-chevron-down text-sm transition-transform duration-200' id="user-menu-chevron"></i>
            </button>
            
            <div id="user-dropdown" class="origin-top-right absolute right-0 mt-2 w-48 rounded-md shadow-lg bg-white ring-1 ring-black ring-opacity-5 divide-y divide-gray-100 hidden z-50">
              <div class="py-1">
                <a href="portal/index.html" class="group flex items-center px-4 py-2 text-sm text-gray-700 hover:bg-gray-100 hover:text-gray-900">
                  <i class='bx bxs-dashboard mr-3 text-gray-400 group-hover:text-gray-500 text-lg'></i>
                  Dashboard
                </a>
              </div>
              <div class="py-1">
                <button id="logout-btn-desktop" class="group flex w-full items-center px-4 py-2 text-sm text-red-600 hover:bg-red-50 hover:text-red-700">
                  <i class='bx bx-log-out mr-3 text-red-400 group-hover:text-red-500 text-lg'></i>
                  Log Out
                </button>
              </div>
            </div>
          </div>
        `;

        // Dropdown Toggle Logic
        const dropdownBtn = document.getElementById("user-menu-button");
        const dropdownMenu = document.getElementById("user-dropdown");
        const chevron = document.getElementById("user-menu-chevron");

        dropdownBtn.addEventListener("click", (e) => {
          e.stopPropagation(); // Prevents the document click listener from firing immediately
          dropdownMenu.classList.toggle("hidden");
          chevron.classList.toggle("rotate-180"); // Flips the arrow upside down
        });

        // Close dropdown when clicking outside
        document.addEventListener("click", (e) => {
          if (
            !dropdownMenu.contains(e.target) &&
            !dropdownBtn.contains(e.target)
          ) {
            dropdownMenu.classList.add("hidden");
            chevron.classList.remove("rotate-180");
          }
        });

        document
          .getElementById("logout-btn-desktop")
          ?.addEventListener("click", handleLogout);
      }

      // --- Update Mobile Navbar (Stacked) ---
      if (mobileAuthLink) {
        mobileAuthLink.outerHTML = `
          <div class="pt-4 pb-2 border-t border-red-800/50 mt-2">
            <div class="flex items-center px-3 mb-3">
              <i class='bx bx-user-circle text-white text-2xl mr-2'></i>
              <span class="text-white font-medium truncate">${userEmail}</span>
            </div>
            <a href="portal/index.html" class="text-white block px-3 py-2 rounded-md text-base font-bold bg-gray-900 mb-1">
              <i class='bx bxs-dashboard mr-2'></i>Dashboard
            </a>
            <button id="logout-btn-mobile" class="text-white w-full text-left px-3 py-2 rounded-md text-base font-bold bg-red-900 hover:bg-red-800 transition">
              <i class='bx bx-log-out mr-2'></i>Log Out
            </button>
          </div>
        `;

        document
          .getElementById("logout-btn-mobile")
          ?.addEventListener("click", handleLogout);
      }
    }
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
      console.error("Error signing out:", error.message);
      if (typeof showToast === "function")
        showToast("Error signing out.", "error");
    } else {
      window.location.reload();
    }
  } catch (err) {
    console.error("Logout error:", err);
  }
}
