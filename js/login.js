document.addEventListener("DOMContentLoaded", () => {
  // --- Password Toggle ---
  const passwordInput = document.getElementById("password");
  const toggleButton = document.getElementById("toggle-password");
  const eyeIcon = document.getElementById("eye-icon");

  if (passwordInput && toggleButton && eyeIcon) {
    toggleButton.addEventListener("click", () => {
      const type =
        passwordInput.getAttribute("type") === "password" ? "text" : "password";
      passwordInput.setAttribute("type", type);

      if (type === "text") {
        eyeIcon.classList.remove("bx-show");
        eyeIcon.classList.add("bx-hide");
      } else {
        eyeIcon.classList.remove("bx-hide");
        eyeIcon.classList.add("bx-show");
      }
    });
  }

  // --- Login Form Submission ---
  const form = document.querySelector("form");
  const submitBtn = form?.querySelector('button[type="submit"]');

  if (form) {
    form.addEventListener("submit", async (e) => {
      e.preventDefault();

      const email = document.getElementById("email")?.value.trim();
      const password = document.getElementById("password")?.value;

      if (!email || !password) {
        showToast("Please fill in all fields.", "error");
        return;
      }

      // Disable button and show loading state
      const originalText = submitBtn.textContent;
      submitBtn.disabled = true;
      submitBtn.textContent = "Signing in...";
      submitBtn.classList.add("opacity-70", "cursor-not-allowed");

      try {
        const { data, error } = await supabaseClient.auth.signInWithPassword({
          email,
          password,
        });

        if (error) {
          showToast(error.message, "error");
        } else {
          showToast("Signed in successfully! Redirecting...", "success");
          // Redirect to blog (or home) after a short delay
          setTimeout(() => {
            window.location.href = "blog.html";
          }, 1200);
          return; // Don't re-enable button since we're redirecting
        }
      } catch (err) {
        showToast("An unexpected error occurred. Please try again.", "error");
        console.error("Login error:", err);
      }

      // Re-enable button on error
      submitBtn.disabled = false;
      submitBtn.textContent = originalText;
      submitBtn.classList.remove("opacity-70", "cursor-not-allowed");
    });
  }
});
