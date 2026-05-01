/**
 * Toast Notification Utility
 * Provides user feedback for auth actions (success, error, info).
 */

function showToast(message, type = "info", duration = 4000) {
  // Remove any existing toast
  const existing = document.getElementById("auth-toast");
  if (existing) existing.remove();

  const toast = document.createElement("div");
  toast.id = "auth-toast";

  // Color schemes
  const colors = {
    success: {
      bg: "bg-green-50",
      border: "border-green-300",
      text: "text-green-800",
      icon: "bx-check-circle",
      iconColor: "text-green-500",
    },
    error: {
      bg: "bg-red-50",
      border: "border-red-300",
      text: "text-red-800",
      icon: "bx-error-circle",
      iconColor: "text-red-500",
    },
    info: {
      bg: "bg-blue-50",
      border: "border-blue-300",
      text: "text-blue-800",
      icon: "bx-info-circle",
      iconColor: "text-blue-500",
    },
  };

  const c = colors[type] || colors.info;

  // Build the classes.
  // 'left-1/2 transform -translate-x-1/2' handles the perfect horizontal centering.
  // '-translate-y-4 opacity-0' handles the initial hidden state for animation.
  toast.className = `fixed top-20 left-1/2 transform -translate-x-1/2 z-[9999] flex items-center gap-3 px-5 py-3.5 rounded-xl shadow-xl border ${c.bg} ${c.border} ${c.text} text-sm font-medium max-w-md w-[90vw] sm:w-auto transition-all duration-300 ease-out -translate-y-4 opacity-0`;

  toast.innerHTML = `
    <i class="bx ${c.icon} text-xl ${c.iconColor} shrink-0"></i>
    <span class="flex-1">${message}</span>
    <button onclick="this.parentElement.remove()" class="ml-2 opacity-60 hover:opacity-100 transition-opacity shrink-0">
      <i class="bx bx-x text-lg"></i>
    </button>
  `;

  document.body.appendChild(toast);

  // Animate in by swapping Tailwind classes
  requestAnimationFrame(() => {
    requestAnimationFrame(() => {
      toast.classList.remove("-translate-y-4", "opacity-0");
      toast.classList.add("translate-y-0", "opacity-100");
    });
  });

  // Auto-dismiss by swapping Tailwind classes back
  setTimeout(() => {
    toast.classList.remove("translate-y-0", "opacity-100");
    toast.classList.add("-translate-y-4", "opacity-0");
    setTimeout(() => toast.remove(), 300);
  }, duration);
}
