document.addEventListener("DOMContentLoaded", () => {
  const form = document.querySelector("form");
  const submitBtn = form?.querySelector('button[type="submit"]');

  if (form) {
    form.addEventListener("submit", async (e) => {
      e.preventDefault();

      const email = document.getElementById("email")?.value.trim();

      if (!email) {
        showToast("Please enter your email address.", "error");
        return;
      }

      // Disable button and show loading state
      const originalText = submitBtn.textContent;
      submitBtn.disabled = true;
      submitBtn.textContent = "Sending...";
      submitBtn.classList.add("opacity-70", "cursor-not-allowed");

      try {
        const { error } = await supabaseClient.auth.resetPasswordForEmail(email, {
          redirectTo: window.location.origin + "/reset-password.html",
        });

        if (error) {
          showToast(error.message, "error");
        } else {
          showToast(
            "Password reset link sent! Check your email inbox.",
            "success",
            6000,
          );
        }
      } catch (err) {
        showToast("An unexpected error occurred. Please try again.", "error");
        console.error("Forgot password error:", err);
      }

      // Re-enable button
      submitBtn.disabled = false;
      submitBtn.textContent = originalText;
      submitBtn.classList.remove("opacity-70", "cursor-not-allowed");
    });
  }
});
