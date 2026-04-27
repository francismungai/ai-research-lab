document.addEventListener("DOMContentLoaded", () => {
  // --- Password Toggle (supports multiple toggle buttons) ---
  const toggleButtons = document.querySelectorAll(".toggle-password");

  toggleButtons.forEach((button) => {
    button.addEventListener("click", () => {
      const targetId = button.getAttribute("data-target");
      const passwordInput = document.getElementById(targetId);
      const eyeIcon = button.querySelector("i");

      if (passwordInput && eyeIcon) {
        const type =
          passwordInput.getAttribute("type") === "password"
            ? "text"
            : "password";
        passwordInput.setAttribute("type", type);

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

  // --- Signup Form Submission ---
  const form = document.querySelector("form");
  const submitBtn = form?.querySelector('button[type="submit"]');

  if (form) {
    form.addEventListener("submit", async (e) => {
      e.preventDefault();

      const email = document.getElementById("email")?.value.trim();
      const password = document.getElementById("password")?.value;
      const confirmPassword =
        document.getElementById("confirm-password")?.value;
      const passwordHint =
        document.getElementById("password-hint")?.value.trim();

      // Validation
      if (!email || !password || !confirmPassword) {
        showToast("Please fill in all required fields.", "error");
        return;
      }

      if (password.length < 6) {
        showToast("Password must be at least 6 characters.", "error");
        return;
      }

      if (password !== confirmPassword) {
        showToast("Passwords do not match.", "error");
        return;
      }

      // Disable button and show loading state
      const originalText = submitBtn.textContent;
      submitBtn.disabled = true;
      submitBtn.textContent = "Creating account...";
      submitBtn.classList.add("opacity-70", "cursor-not-allowed");

      try {
        const { data, error } = await supabaseClient.auth.signUp({
          email,
          password,
          options: {
            data: {
              password_hint: passwordHint || "",
            },
          },
        });

        if (error) {
          showToast(error.message, "error");
        } else if (
          data?.user?.identities &&
          data.user.identities.length === 0
        ) {
          // User already exists
          showToast(
            "An account with this email already exists. Please sign in.",
            "error",
          );
        } else {
          showToast(
            "Account created! Check your email to confirm your account.",
            "success",
            6000,
          );
          // Redirect to login after a delay
          setTimeout(() => {
            window.location.href = "login.html";
          }, 3000);
          return;
        }
      } catch (err) {
        showToast("An unexpected error occurred. Please try again.", "error");
        console.error("Signup error:", err);
      }

      // Re-enable button on error
      submitBtn.disabled = false;
      submitBtn.textContent = originalText;
      submitBtn.classList.remove("opacity-70", "cursor-not-allowed");
    });
  }
});
