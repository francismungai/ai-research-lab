/**
 * Simple Vanilla JS Component Loader
 * Fetches HTML fragments and injects them into specified elements.
 */
async function loadComponent(elementId, filePath, onLoadCallback = null) {
  const container = document.getElementById(elementId);

  if (!container) {
    console.warn(`Loader: Element with id "${elementId}" not found.`);
    return;
  }

  try {
    const response = await fetch(filePath);

    if (!response.ok) {
      throw new Error(`Failed to load ${filePath}: ${response.statusText}`);
    }

    // Inject the HTML synchronously
    const htmlContent = await response.text();
    container.innerHTML = htmlContent;

    // Execute the callback function if one was provided
    if (onLoadCallback && typeof onLoadCallback === "function") {
      onLoadCallback();
    }
  } catch (error) {
    console.error("Component Loader Error:", error);
    container.innerHTML = `<p class="text-red-500 p-4">Error loading component: ${filePath}</p>`;
  }
}

// Initialize loading when the DOM is ready
document.addEventListener("DOMContentLoaded", () => {
  // Pass initNavbar as a callback so it only runs AFTER navbar.html is injected
  loadComponent("navbar-placeholder", "components/navbar.html", initNavbar);

  // Footer needs no scripts, so we just omit the callback parameter
  loadComponent("footer-placeholder", "components/footer.html");
});
