document.addEventListener("DOMContentLoaded", () => {
  const accordionItems = document.querySelectorAll(".accordion-item");

  accordionItems.forEach((item) => {
    const btn = item.querySelector(".accordion-btn");
    const content = item.querySelector(".accordion-content");
    const icon = item.querySelector("i");

    btn.addEventListener("click", () => {
      const isCurrentlyOpen = !content.classList.contains("hidden");

      // Optional: Close all other accordions when one is opened (Accordion behavior)
      // Comment out this block if you want users to be able to open multiple at once
      document
        .querySelectorAll(".accordion-content")
        .forEach((c) => c.classList.add("hidden"));
      document
        .querySelectorAll(".accordion-btn i")
        .forEach((i) => i.classList.remove("rotate-180"));

      // Toggle the clicked one
      if (!isCurrentlyOpen) {
        content.classList.remove("hidden");
        icon.classList.add("rotate-180");
      }
    });
  });
});
