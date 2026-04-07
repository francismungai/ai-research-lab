document.addEventListener("DOMContentLoaded", () => {
  // Select all the toggle buttons on the page
  const toggleButtons = document.querySelectorAll(".toggle-password");

  toggleButtons.forEach((button) => {
    button.addEventListener("click", () => {
      // Find the specific input this button controls using data-target
      const targetId = button.getAttribute("data-target");
      const passwordInput = document.getElementById(targetId);
      const eyeIcon = button.querySelector("i");

      if (passwordInput && eyeIcon) {
        // Toggle the input type
        const type =
          passwordInput.getAttribute("type") === "password"
            ? "text"
            : "password";
        passwordInput.setAttribute("type", type);

        // Toggle the eye icon class
        if (type === "text") {
          eyeIcon.classList.remove("bx-show");
          eyeIcon.classList.add("bx-hide");
        } else {
          eyeIcon.classList.remove("bx-hide");
          eyeIcon.classList.add("bx-show");
        }
      }
    });
  });
});
