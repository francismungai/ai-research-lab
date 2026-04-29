// --- 1. HTML TEMPLATES ---
const portalSidebarHtml = `
<aside id="portal-sidebar" class="w-64 bg-[#C53030] border-r border-red-800 flex flex-col hidden md:flex shadow-xl z-50 absolute md:relative h-full">
  <div class="h-16 flex items-center px-6 border-b border-red-800/50 justify-between">
    <span class="text-xl font-bold text-white tracking-tight">AI Lab Portal</span>
    <button id="close-sidebar-btn" class="md:hidden text-red-200 hover:text-white text-2xl"><i class='bx bx-x'></i></button>
  </div>

  <nav class="flex-1 overflow-y-auto py-4 px-3 space-y-1" id="sidebar-nav">
    <a href="index.html" class="nav-link flex items-center px-3 py-2.5 text-sm font-medium rounded-lg text-red-100 hover:bg-[#A52828] hover:text-white transition-colors">
      <i class='bx bxs-dashboard text-lg mr-3'></i> Dashboard
    </a>
    <a href="../index.html" target="_blank" class="flex items-center px-3 py-2.5 text-sm font-medium rounded-lg text-red-100 hover:bg-[#A52828] hover:text-white transition-colors">
      <i class='bx bx-globe text-lg mr-3'></i> View Live Site
    </a>
    <a href="my-drafts.html" class="nav-link flex items-center px-3 py-2.5 text-sm font-medium rounded-lg text-red-100 hover:bg-[#A52828] hover:text-white transition-colors">
      <i class='bx bx-edit text-lg mr-3'></i> My Blog Drafts
    </a>

    <div class="pt-4 pb-2 role-restricted hidden" data-allowed-roles="editor,admin">
      <p class="px-3 text-xs font-bold text-red-300 uppercase tracking-wider">Management</p>
    </div>

    <a href="manage-blogs.html" data-allowed-roles="editor,admin" class="nav-link role-restricted hidden items-center px-3 py-2.5 text-sm font-medium rounded-lg text-red-100 hover:bg-[#A52828] hover:text-white transition-colors">
      <i class='bx bx-news text-lg mr-3'></i> Blog Posts
    </a>
    <a href="manage-pubs.html" data-allowed-roles="editor,admin" class="nav-link role-restricted hidden items-center px-3 py-2.5 text-sm font-medium rounded-lg text-red-100 hover:bg-[#A52828] hover:text-white transition-colors">
      <i class='bx bx-file text-lg mr-3'></i> Publications
    </a>
    <a href="manage-books.html" data-allowed-roles="editor,admin" class="nav-link role-restricted hidden items-center px-3 py-2.5 text-sm font-medium rounded-lg text-red-100 hover:bg-[#A52828] hover:text-white transition-colors">
      <i class='bx bx-book text-lg mr-3'></i> Books
    </a>
    <a href="manage-people.html" data-allowed-roles="admin" class="nav-link role-restricted hidden items-center px-3 py-2.5 text-sm font-medium rounded-lg text-red-100 hover:bg-[#A52828] hover:text-white transition-colors">
      <i class='bx bx-group text-lg mr-3'></i> People
    </a>
    <a href="manage-users.html" data-allowed-roles="admin" class="nav-link role-restricted hidden items-center px-3 py-2.5 text-sm font-medium rounded-lg text-red-100 hover:bg-[#A52828] hover:text-white transition-colors border-t border-red-800/50 mt-2 pt-3">
      <i class='bx bx-shield-quarter text-lg mr-3'></i> System Users
    </a>
  </nav>

  <div class="p-4 border-t border-red-800/50">
    <div class="flex items-center gap-3 mb-4 px-2">
      <div class="w-8 h-8 rounded-full bg-red-900 flex items-center justify-center text-red-100 font-bold" id="user-initial">
        <i class='bx bx-user'></i>
      </div>
      <div class="flex-1 min-w-0">
        <p class="text-sm font-medium text-white truncate" id="user-email">Loading...</p>
        <p class="text-xs text-red-200 capitalize" id="user-role">...</p>
      </div>
    </div>
    <button id="logout-btn" class="w-full flex items-center justify-center px-4 py-2 border border-red-400/50 shadow-sm text-sm font-medium rounded-lg text-white bg-transparent hover:bg-[#A52828] transition-colors focus:outline-none">
      <i class='bx bx-log-out mr-2'></i> Sign out
    </button>
  </div>
</aside>
`;

const portalHeaderHtml = `
<header class="md:hidden h-16 bg-[#C53030] border-b border-red-800 flex items-center justify-between px-4 z-10 shadow-md">
  <span class="text-lg font-bold text-white">AI Lab Portal</span>
  <button id="mobile-menu-btn" class="p-2 rounded-md text-red-100 hover:text-white hover:bg-[#A52828] focus:outline-none">
    <i class='bx bx-menu text-2xl'></i>
  </button>
</header>
`;

document.addEventListener("DOMContentLoaded", async () => {
  // --- 2. INJECT LAYOUT UI ---
  const sidebarPlaceholder = document.getElementById(
    "portal-sidebar-placeholder",
  );
  const headerPlaceholder = document.getElementById(
    "portal-header-placeholder",
  );

  if (sidebarPlaceholder) sidebarPlaceholder.outerHTML = portalSidebarHtml;
  if (headerPlaceholder) headerPlaceholder.outerHTML = portalHeaderHtml;

  // --- 3. DYNAMIC ACTIVE LINK HIGHLIGHTING ---
  const currentPath = window.location.pathname.split("/").pop() || "index.html";
  const navLinks = document.querySelectorAll(".nav-link");

  navLinks.forEach((link) => {
    if (link.getAttribute("href") === currentPath) {
      link.classList.remove(
        "text-red-100",
        "hover:bg-[#A52828]",
        "hover:text-white",
      );
      link.classList.add("bg-[#A52828]", "text-white", "shadow-inner");
    }
  });

  // --- 4. MOBILE MENU LOGIC ---
  const mobileMenuBtn = document.getElementById("mobile-menu-btn");
  const closeSidebarBtn = document.getElementById("close-sidebar-btn");
  const sidebar = document.getElementById("portal-sidebar");

  if (mobileMenuBtn && sidebar && closeSidebarBtn) {
    mobileMenuBtn.addEventListener("click", () =>
      sidebar.classList.remove("hidden"),
    );
    closeSidebarBtn.addEventListener("click", () =>
      sidebar.classList.add("hidden"),
    );
  }

  // --- 5. AUTHENTICATION & SECURITY GUARD ---
  try {
    const {
      data: { session },
      error: sessionError,
    } = await supabaseClient.auth.getSession();

    if (sessionError || !session) {
      window.location.replace("../login.html");
      return;
    }

    const { data: profile, error: profileError } = await supabaseClient
      .from("profiles")
      .select("role")
      .eq("id", session.user.id)
      .single();

    if (profileError || !profile) {
      window.location.replace("../index.html");
      return;
    }

    const userRole = profile.role;

    if (userRole === "user") {
      window.location.replace("../index.html");
      return;
    }

    // --- 6. ROLE-BASED UI FILTERING ---
    const restrictedElements = document.querySelectorAll(
      "[data-allowed-roles]",
    );
    restrictedElements.forEach((el) => {
      const allowedRoles = el.getAttribute("data-allowed-roles").split(",");
      if (allowedRoles.includes(userRole)) {
        el.classList.remove("hidden");
        if (el.tagName === "A") el.classList.add("flex");
      } else {
        el.remove();
      }
    });

    // --- 7. POPULATE USER DATA ---
    const emailElem = document.getElementById("user-email");
    const roleElem = document.getElementById("user-role");
    const initialElem = document.getElementById("user-initial");

    if (emailElem) emailElem.textContent = session.user.email;
    if (roleElem) roleElem.textContent = userRole;
    if (initialElem && session.user.email) {
      initialElem.innerHTML = session.user.email.charAt(0).toUpperCase();
    }

    // --- 8. LOGOUT LOGIC ---
    const logoutBtn = document.getElementById("logout-btn");
    if (logoutBtn) {
      logoutBtn.addEventListener("click", async () => {
        await supabaseClient.auth.signOut();
        window.location.replace("../login.html");
      });
    }

    // UNCLOAK THE PAGE
    document.body.style.display = "flex";
  } catch (err) {
    console.error("Auth check failed:", err);
    window.location.replace("../login.html");
  }
});
