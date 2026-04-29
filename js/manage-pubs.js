document.addEventListener("DOMContentLoaded", async () => {
  // --- 1. PAGE-LEVEL SECURITY GUARD ---
  // Ensure the user hasn't bypassed the portal.js hidden links
  const {
    data: { session },
  } = await supabaseClient.auth.getSession();
  if (!session) return; // Let portal.js handle the kickout

  const { data: profile } = await supabaseClient
    .from("profiles")
    .select("role")
    .eq("id", session.user.id)
    .single();

  if (!profile || (profile.role !== "admin" && profile.role !== "editor")) {
    alert("Unauthorized access. Redirecting to dashboard.");
    window.location.replace("index.html");
    return;
  }

  // --- 2. DOM ELEMENTS ---
  const tableBody = document.getElementById("pubs-table-body");
  const modal = document.getElementById("pub-modal");
  const modalPanel = document.getElementById("pub-modal-panel");
  const form = document.getElementById("pub-form");
  const saveBtn = document.getElementById("save-pub-btn");
  const modalTitle = document.getElementById("modal-title");

  // --- 3. FETCH & RENDER DATA ---
  async function loadPublications() {
    const { data, error } = await supabaseClient
      .from("publications")
      .select("*")
      .order("pub_year", { ascending: false });

    if (error) {
      console.error("Error fetching publications:", error);
      tableBody.innerHTML = `<tr><td colspan="4" class="p-4 text-center text-red-500">Failed to load data.</td></tr>`;
      return;
    }

    if (data.length === 0) {
      tableBody.innerHTML = `<tr><td colspan="4" class="p-4 text-center text-gray-500">No publications found.</td></tr>`;
      return;
    }

    tableBody.innerHTML = data
      .map(
        (pub) => `
      <tr class="hover:bg-gray-50 transition border-b border-gray-100 last:border-0">
        <td class="p-4">
          <p class="text-sm font-bold text-gray-900">${pub.title}</p>
          <p class="text-xs text-gray-500 mt-1">${pub.authors}</p>
          ${pub.is_sample ? '<span class="inline-block mt-1 px-2 py-0.5 bg-red-100 text-red-800 text-[10px] rounded-full font-semibold">Sample</span>' : ""}
        </td>
        <td class="p-4 text-sm text-gray-600">${pub.venue || "-"}</td>
        <td class="p-4 text-sm text-gray-600">${pub.pub_year || "-"}</td>
        <td class="p-4 text-right whitespace-nowrap">
          <button onclick="editPub('${pub.id}')" class="text-blue-600 hover:text-blue-800 p-1 mx-1 transition"><i class='bx bx-edit text-lg'></i></button>
          <button onclick="deletePub('${pub.id}')" class="text-red-500 hover:text-red-700 p-1 mx-1 transition"><i class='bx bx-trash text-lg'></i></button>
        </td>
      </tr>
    `,
      )
      .join("");

    // Store data globally for easy editing without re-fetching
    window.pubsData = data;
  }

  // --- 4. MODAL LOGIC ---
  function openModal(isEdit = false) {
    modalTitle.textContent = isEdit ? "Edit Publication" : "Add Publication";
    modal.classList.remove("hidden");
    // Small delay to allow display:block to apply before animating translate
    setTimeout(() => {
      modalPanel.classList.remove("translate-x-full");
    }, 10);
  }

  function closeModal() {
    modalPanel.classList.add("translate-x-full");
    // Wait for animation to finish before hiding
    setTimeout(() => {
      modal.classList.add("hidden");
      form.reset();
      document.getElementById("pub-id").value = "";
    }, 300);
  }

  document.getElementById("add-pub-btn").addEventListener("click", () => {
    form.reset();
    document.getElementById("pub-id").value = "";
    openModal(false);
  });

  document
    .getElementById("close-modal-btn")
    .addEventListener("click", closeModal);
  document
    .getElementById("cancel-modal-btn")
    .addEventListener("click", closeModal);

  // Close modal if clicking on the dark overlay background
  modal.addEventListener("click", (e) => {
    if (e.target === modal) closeModal();
  });

  // --- 5. CREATE / UPDATE (UPSERT) ---
  saveBtn.addEventListener("click", async () => {
    if (!form.checkValidity()) {
      form.reportValidity(); // Triggers native browser validation tooltips
      return;
    }

    const id = document.getElementById("pub-id").value;
    const pubData = {
      title: document.getElementById("pub-title").value.trim(),
      authors: document.getElementById("pub-authors").value.trim(),
      description: document.getElementById("pub-desc").value.trim(),
      venue: document.getElementById("pub-venue").value.trim(),
      pub_year: document.getElementById("pub-year").value.trim(),
      paper_url: document.getElementById("pub-paper-url").value.trim(),
      code_url: document.getElementById("pub-code-url").value.trim(),
      is_sample: document.getElementById("pub-is-sample").checked,
    };

    const originalText = saveBtn.innerHTML;
    saveBtn.innerHTML =
      "<i class='bx bx-loader-alt bx-spin mr-2'></i> Saving...";
    saveBtn.disabled = true;

    try {
      let response;
      if (id) {
        // UPDATE existing
        response = await supabaseClient
          .from("publications")
          .update(pubData)
          .eq("id", id);
      } else {
        // INSERT new
        response = await supabaseClient.from("publications").insert([pubData]);
      }

      if (response.error) throw response.error;

      closeModal();
      await loadPublications(); // Refresh table

      // Optional: If you have a toast system, call it here
      alert("Saved successfully! GitHub Actions is rebuilding the site.");
    } catch (err) {
      console.error("Save error:", err);
      alert("Failed to save: " + err.message);
    } finally {
      saveBtn.innerHTML = originalText;
      saveBtn.disabled = false;
    }
  });

  // --- 6. GLOBAL HELPER FUNCTIONS ---
  // Attaching to window so inline HTML onclick="" handlers can see them
  window.editPub = (id) => {
    const pub = window.pubsData.find((p) => p.id === id);
    if (!pub) return;

    document.getElementById("pub-id").value = pub.id;
    document.getElementById("pub-title").value = pub.title || "";
    document.getElementById("pub-authors").value = pub.authors || "";
    document.getElementById("pub-desc").value = pub.description || "";
    document.getElementById("pub-venue").value = pub.venue || "";
    document.getElementById("pub-year").value = pub.pub_year || "";
    document.getElementById("pub-paper-url").value = pub.paper_url || "";
    document.getElementById("pub-code-url").value = pub.code_url || "";
    document.getElementById("pub-is-sample").checked = pub.is_sample;

    openModal(true);
  };

  window.deletePub = async (id) => {
    if (
      !confirm(
        "Are you sure you want to delete this publication? This action triggers a live site rebuild.",
      )
    )
      return;

    try {
      const { error } = await supabaseClient
        .from("publications")
        .delete()
        .eq("id", id);
      if (error) throw error;
      await loadPublications();
    } catch (err) {
      console.error("Delete error:", err);
      alert("Failed to delete: " + err.message);
    }
  };

  // --- INIT ---
  loadPublications();
});
