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

  // --- Check for recovery session from Supabase email link ---
  // Supabase sends a hash fragment with access_token when the user
  // clicks the password reset link in their email.
  supabaseClient.auth.onAuthStateChange(async (event, session) => {
    if (event === "PASSWORD_RECOVERY") {
      showToast(
        "You can now set your new password below.",
        "info",
        5000,
      );
    }
  });

  // --- Reset Password Form Submission ---
  const form = document.querySelector("form");
  const submitBtn = form?.querySelector('button[type="submit"]');

  if (form) {
    form.addEventListener("submit", async (e) => {
      e.preventDefault();

      const newPassword = document.getElementById("new-password")?.value;
      const confirmNewPassword =
        document.getElementById("confirm-new-password")?.value;
      const passwordHint =
        document.getElementById("password-hint")?.value.trim();

      // Validation
      if (!newPassword || !confirmNewPassword) {
        showToast("Please fill in all required fields.", "error");
        return;
      }

      if (newPassword.length < 6) {
        showToast("Password must be at least 6 characters.", "error");
        return;
      }

      if (newPassword !== confirmNewPassword) {
        showToast("Passwords do not match.", "error");
        return;
      }

      // Disable button and show loading state
      const originalText = submitBtn.textContent;
      submitBtn.disabled = true;
      submitBtn.textContent = "Resetting password...";
      submitBtn.classList.add("opacity-70", "cursor-not-allowed");

      try {
        const updatePayload = {
          password: newPassword,
        };

        // Store the new password hint in user_metadata if provided
        if (passwordHint) {
          updatePayload.data = { password_hint: passwordHint };
        }

        const { error } = await supabaseClient.auth.updateUser(updatePayload);

        if (error) {
          showToast(error.message, "error");
        } else {
          showToast(
            "Password updated successfully! Redirecting to sign in...",
            "success",
            4000,
          );
          setTimeout(() => {
            window.location.href = "login.html";
          }, 2000);
          return;
        }
      } catch (err) {
        showToast("An unexpected error occurred. Please try again.", "error");
        console.error("Reset password error:", err);
      }

      // Re-enable button on error
      submitBtn.disabled = false;
      submitBtn.textContent = originalText;
      submitBtn.classList.remove("opacity-70", "cursor-not-allowed");
    });
  }
});
