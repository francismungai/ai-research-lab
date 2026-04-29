document.addEventListener("DOMContentLoaded", async () => {
  // --- 1. PAGE-LEVEL SECURITY GUARD ---
  const {
    data: { session },
  } = await supabaseClient.auth.getSession();
  if (!session) return;

  const { data: profile } = await supabaseClient
    .from("profiles")
    .select("role")
    .eq("id", session.user.id)
    .single();

  // STRICT CHECK: Only Admins can manage people. Editors are kicked out.
  if (!profile || profile.role !== "admin") {
    alert("Administrative access required. Redirecting to dashboard.");
    window.location.replace("index.html");
    return;
  }

  // --- 2. DOM ELEMENTS ---
  const tableBody = document.getElementById("people-table-body");
  const modal = document.getElementById("person-modal");
  const modalPanel = document.getElementById("person-modal-panel");
  const form = document.getElementById("person-form");
  const saveBtn = document.getElementById("save-person-btn");
  const modalTitle = document.getElementById("modal-title");

  // Dynamic UI for Alumni fields
  const categorySelect = document.getElementById("person-category");
  const alumniContainer = document.getElementById("alumni-fields-container");

  // Show/Hide Alumni fields based on category selection
  categorySelect.addEventListener("change", (e) => {
    if (e.target.value === "alumni") {
      alumniContainer.classList.remove("opacity-50");
    } else {
      alumniContainer.classList.add("opacity-50");
    }
  });

  // --- 3. FETCH & RENDER DATA ---
  async function loadPeople() {
    // Order by category first, then by name
    const { data, error } = await supabaseClient
      .from("people")
      .select("*")
      .order("category", { ascending: true })
      .order("name", { ascending: true });

    if (error) {
      console.error("Error fetching people:", error);
      tableBody.innerHTML = `<tr><td colspan="4" class="p-4 text-center text-red-500">Failed to load data.</td></tr>`;
      return;
    }

    if (data.length === 0) {
      tableBody.innerHTML = `<tr><td colspan="4" class="p-4 text-center text-gray-500">No lab members found.</td></tr>`;
      return;
    }

    tableBody.innerHTML = data
      .map((person) => {
        // Build a small string of active links for the table view
        let linksHtml = "";
        if (person.scholar_url)
          linksHtml += `<a href="${person.scholar_url}" target="_blank" class="text-blue-600 hover:text-blue-800 text-xs mr-2"><i class='bx bxl-google'></i> Scholar</a>`;
        if (person.website_url)
          linksHtml += `<a href="${person.website_url}" target="_blank" class="text-gray-600 hover:text-gray-900 text-xs mr-2"><i class='bx bx-link-external'></i> Web</a>`;

        // Category badge styling
        const catColors = {
          faculty: "bg-red-100 text-red-800",
          student: "bg-blue-100 text-blue-800",
          staff: "bg-purple-100 text-purple-800",
          alumni: "bg-gray-200 text-gray-800",
          collaborator: "bg-green-100 text-green-800",
        };
        const badgeClass =
          catColors[person.category] || "bg-gray-100 text-gray-800";

        return `
      <tr class="hover:bg-gray-50 transition border-b border-gray-100 last:border-0">
        <td class="p-4">
          <div class="flex items-center gap-3">
            ${
              person.photo_url
                ? `<img src="${person.photo_url}" alt="Photo" class="w-10 h-10 rounded-full object-cover shadow-sm bg-gray-200" onerror="this.src='https://ui-avatars.com/api/?name=${encodeURIComponent(person.name)}&background=random'">`
                : `<div class="w-10 h-10 rounded-full bg-gray-200 flex items-center justify-center text-gray-500 text-sm font-bold shadow-sm">${person.name.charAt(0)}</div>`
            }
            <div>
              <p class="text-sm font-bold text-gray-900">${person.name}</p>
              <p class="text-xs text-gray-500 mt-1">${person.role || "-"}</p>
            </div>
          </div>
        </td>
        <td class="p-4 text-sm">
          <span class="px-2 py-1 rounded-full text-xs font-semibold capitalize ${badgeClass}">${person.category}</span>
        </td>
        <td class="p-4 text-sm flex-wrap items-center pt-6">
          ${linksHtml || '<span class="text-xs text-gray-400">No links</span>'}
        </td>
        <td class="p-4 text-right whitespace-nowrap">
          <button onclick="editPerson('${person.id}')" class="text-blue-600 hover:text-blue-800 p-1 mx-1 transition"><i class='bx bx-edit text-lg'></i></button>
          <button onclick="deletePerson('${person.id}')" class="text-red-500 hover:text-red-700 p-1 mx-1 transition"><i class='bx bx-trash text-lg'></i></button>
        </td>
      </tr>
    `;
      })
      .join("");

    window.peopleData = data;
  }

  // --- 4. MODAL LOGIC ---
  function openModal(isEdit = false) {
    modalTitle.textContent = isEdit ? "Edit Person" : "Add Person";

    // Trigger the change event to set initial opacity of alumni fields
    categorySelect.dispatchEvent(new Event("change"));

    modal.classList.remove("hidden");
    setTimeout(() => {
      modalPanel.classList.remove("translate-x-full");
    }, 10);
  }

  function closeModal() {
    modalPanel.classList.add("translate-x-full");
    setTimeout(() => {
      modal.classList.add("hidden");
      form.reset();
      document.getElementById("person-id").value = "";
    }, 300);
  }

  document.getElementById("add-person-btn").addEventListener("click", () => {
    form.reset();
    document.getElementById("person-id").value = "";
    openModal(false);
  });

  document
    .getElementById("close-modal-btn")
    .addEventListener("click", closeModal);
  document
    .getElementById("cancel-modal-btn")
    .addEventListener("click", closeModal);

  modal.addEventListener("click", (e) => {
    if (e.target === modal) closeModal();
  });

  // --- 5. CREATE / UPDATE (UPSERT) ---
  saveBtn.addEventListener("click", async () => {
    if (!form.checkValidity()) {
      form.reportValidity();
      return;
    }

    const id = document.getElementById("person-id").value;
    const personData = {
      name: document.getElementById("person-name").value.trim(),
      category: document.getElementById("person-category").value,
      role: document.getElementById("person-role").value.trim(),
      photo_url: document.getElementById("person-photo-url").value.trim(),
      scholar_url: document.getElementById("person-scholar").value.trim(),
      dblp_url: document.getElementById("person-dblp").value.trim(),
      website_url: document.getElementById("person-website").value.trim(),
      degree: document.getElementById("person-degree").value.trim(),
      grad_year: document.getElementById("person-grad-year").value.trim(),
      member_key: document.getElementById("person-member-key").value.trim(),
    };

    const originalText = saveBtn.innerHTML;
    saveBtn.innerHTML =
      "<i class='bx bx-loader-alt bx-spin mr-2'></i> Saving...";
    saveBtn.disabled = true;

    try {
      let response;
      if (id) {
        response = await supabaseClient
          .from("people")
          .update(personData)
          .eq("id", id);
      } else {
        response = await supabaseClient.from("people").insert([personData]);
      }

      if (response.error) throw response.error;

      closeModal();
      await loadPeople();
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
  window.editPerson = (id) => {
    const person = window.peopleData.find((p) => p.id === id);
    if (!person) return;

    document.getElementById("person-id").value = person.id;
    document.getElementById("person-name").value = person.name || "";
    document.getElementById("person-category").value = person.category || "";
    document.getElementById("person-role").value = person.role || "";
    document.getElementById("person-photo-url").value = person.photo_url || "";
    document.getElementById("person-scholar").value = person.scholar_url || "";
    document.getElementById("person-dblp").value = person.dblp_url || "";
    document.getElementById("person-website").value = person.website_url || "";
    document.getElementById("person-degree").value = person.degree || "";
    document.getElementById("person-grad-year").value = person.grad_year || "";
    document.getElementById("person-member-key").value =
      person.member_key || "";

    openModal(true);
  };

  window.deletePerson = async (id) => {
    if (
      !confirm(
        "Are you sure you want to remove this person? This action triggers a live site rebuild.",
      )
    )
      return;

    try {
      const { error } = await supabaseClient
        .from("people")
        .delete()
        .eq("id", id);
      if (error) throw error;
      await loadPeople();
    } catch (err) {
      console.error("Delete error:", err);
      alert("Failed to delete: " + err.message);
    }
  };

  // --- INIT ---
  loadPeople();
});
