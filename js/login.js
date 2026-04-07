document.addEventListener("DOMContentLoaded", () => {
  const passwordInput = document.getElementById("password");
  const toggleButton = document.getElementById("toggle-password");
  const eyeIcon = document.getElementById("eye-icon");

  if (passwordInput && toggleButton && eyeIcon) {
    toggleButton.addEventListener("click", () => {
      // Toggle the type attribute
      const type =
        passwordInput.getAttribute("type") === "password" ? "text" : "password";
      passwordInput.setAttribute("type", type);

      // Toggle the icon
      if (type === "text") {
        eyeIcon.classList.remove("bx-show");
        eyeIcon.classList.add("bx-hide");
      } else {
        eyeIcon.classList.remove("bx-hide");
        eyeIcon.classList.add("bx-show");
      }
    });
  }
});
