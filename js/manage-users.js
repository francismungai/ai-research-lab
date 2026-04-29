document.addEventListener("DOMContentLoaded", async () => {
  // --- 1. PAGE-LEVEL SECURITY GUARD ---
  const {
    data: { session },
  } = await supabaseClient.auth.getSession();
  if (!session) return;

  const currentUserId = session.user.id;

  const { data: currentProfile } = await supabaseClient
    .from("profiles")
    .select("role")
    .eq("id", currentUserId)
    .single();

  console.log("Current profile:", currentProfile);

  // STRICT CHECK: Only Admins can manage users.
  if (!currentProfile || currentProfile.role !== "admin") {
    alert("Administrative access required. Redirecting to dashboard.");
    window.location.replace("index.html");
    return;
  }

  // --- 2. DOM ELEMENTS ---
  const tableBody = document.getElementById("users-table-body");

  // --- 3. FETCH & RENDER DATA ---
  async function loadUsers() {
    // Assuming your 'profiles' table has an 'email' column alongside 'id' and 'role'
    // If you don't store email in profiles, you will just see IDs, but standard practice is to copy email on trigger.
    const { data, error } = await supabaseClient
      .from("profiles")
      .select("*")
      .order("role", { ascending: true }); // Groups admins/editors/etc together

    console.log("Profiles data:", data);
    console.log("Profiles error:", error);

    if (error) {
      console.error("Error fetching profiles:", error);
      tableBody.innerHTML = `<tr><td colspan="2" class="p-4 text-center text-red-500">Failed to load system users.</td></tr>`;
      return;
    }

    if (data.length === 0) {
      tableBody.innerHTML = `<tr><td colspan="2" class="p-4 text-center text-gray-500">No users found.</td></tr>`;
      return;
    }

    tableBody.innerHTML = data
      .map((profile) => {
        // Prevent the current admin from accidentally downgrading their own role and locking themselves out
        const isSelf = profile.id === currentUserId;
        const disableSelect = isSelf ? "disabled" : "";
        const selfBadge = isSelf
          ? `<span class="ml-2 text-[10px] bg-red-100 text-[#C53030] px-2 py-0.5 rounded-full font-bold uppercase tracking-wider">You</span>`
          : "";

        // Fallback to displaying ID if email isn't stored in the profiles table
        const displayIdentifier = profile.email || profile.id;

        return `
      <tr class="hover:bg-gray-50 transition border-b border-gray-100 last:border-0">
        <td class="p-4">
          <div class="flex items-center">
            <div class="w-8 h-8 rounded-full bg-gray-200 flex items-center justify-center text-gray-500 font-bold mr-3">
              <i class='bx bx-user'></i>
            </div>
            <div>
              <p class="text-sm font-bold text-gray-900 flex items-center">${displayIdentifier} ${selfBadge}</p>
              <p class="text-xs text-gray-400 font-mono mt-0.5">ID: ${profile.id.substring(0, 12)}...</p>
            </div>
          </div>
        </td>
        <td class="p-4">
          <select 
            onchange="updateUserRole('${profile.id}', this.value)" 
            class="w-full border border-gray-300 rounded-md px-3 py-1.5 text-sm focus:ring-2 focus:ring-[#C53030] focus:border-[#C53030] outline-none bg-white cursor-pointer ${isSelf ? "opacity-50 cursor-not-allowed bg-gray-100" : ""}"
            ${disableSelect}
          >
            <option value="user" ${profile.role === "user" ? "selected" : ""}>User (No Access)</option>
            <option value="contributor" ${profile.role === "contributor" ? "selected" : ""}>Contributor</option>
            <option value="editor" ${profile.role === "editor" ? "selected" : ""}>Editor</option>
            <option value="admin" ${profile.role === "admin" ? "selected" : ""}>Admin</option>
          </select>
        </td>
      </tr>
    `;
      })
      .join("");
  }

  // --- 4. INSTANT UPDATE LOGIC ---
  window.updateUserRole = async (targetUserId, newRole) => {
    try {
      const { error } = await supabaseClient
        .from("profiles")
        .update({ role: newRole })
        .eq("id", targetUserId);

      if (error) throw error;

      // Optional visual feedback
      // if (typeof showToast === "function") showToast("Role updated successfully.", "success");
    } catch (err) {
      console.error("Role update error:", err);
      alert("Failed to update role: " + err.message);
      await loadUsers(); // Revert the dropdown visually if the database update failed
    }
  };

  // --- INIT ---
  loadUsers();
});
