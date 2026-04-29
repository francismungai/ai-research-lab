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

  if (!profile || (profile.role !== "admin" && profile.role !== "editor")) {
    alert("Unauthorized access. Redirecting to dashboard.");
    window.location.replace("index.html");
    return;
  }

  // --- 2. DOM ELEMENTS ---
  const tableBody = document.getElementById("books-table-body");
  const modal = document.getElementById("book-modal");
  const modalPanel = document.getElementById("book-modal-panel");
  const form = document.getElementById("book-form");
  const saveBtn = document.getElementById("save-book-btn");
  const modalTitle = document.getElementById("modal-title");

  // --- 3. FETCH & RENDER DATA ---
  async function loadBooks() {
    const { data, error } = await supabaseClient
      .from("books")
      .select("*")
      .order("pub_year", { ascending: false });

    if (error) {
      console.error("Error fetching books:", error);
      tableBody.innerHTML = `<tr><td colspan="4" class="p-4 text-center text-red-500">Failed to load data.</td></tr>`;
      return;
    }

    if (data.length === 0) {
      tableBody.innerHTML = `<tr><td colspan="4" class="p-4 text-center text-gray-500">No books found.</td></tr>`;
      return;
    }

    tableBody.innerHTML = data
      .map(
        (book) => `
      <tr class="hover:bg-gray-50 transition border-b border-gray-100 last:border-0">
        <td class="p-4">
          <div class="flex items-center gap-3">
            ${book.image_url ? `<img src="${book.image_url}" alt="Cover" class="w-8 h-12 object-cover rounded-sm shadow-sm" onerror="this.style.display='none'">` : ""}
            <div>
              <p class="text-sm font-bold text-gray-900">${book.title}</p>
              <p class="text-xs text-gray-500 mt-1">${book.authors}</p>
            </div>
          </div>
        </td>
        <td class="p-4 text-sm text-gray-600">${book.publisher || "-"}</td>
        <td class="p-4 text-sm text-gray-600">${book.pub_year || "-"}</td>
        <td class="p-4 text-right whitespace-nowrap">
          <button onclick="editBook('${book.id}')" class="text-blue-600 hover:text-blue-800 p-1 mx-1 transition"><i class='bx bx-edit text-lg'></i></button>
          <button onclick="deleteBook('${book.id}')" class="text-red-500 hover:text-red-700 p-1 mx-1 transition"><i class='bx bx-trash text-lg'></i></button>
        </td>
      </tr>
    `,
      )
      .join("");

    window.booksData = data;
  }

  // --- 4. MODAL LOGIC ---
  function openModal(isEdit = false) {
    modalTitle.textContent = isEdit ? "Edit Book" : "Add Book";
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
      document.getElementById("book-id").value = "";
      document.getElementById("book-image-file").value = ""; // Clear file input
    }, 300);
  }

  document.getElementById("add-book-btn").addEventListener("click", () => {
    form.reset();
    document.getElementById("book-id").value = "";
    document.getElementById("book-image-file").value = ""; // Clear file input
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

  // --- 5. CREATE / UPDATE (UPSERT) WITH IMAGE UPLOAD ---
  saveBtn.addEventListener("click", async () => {
    if (!form.checkValidity()) {
      form.reportValidity();
      return;
    }

    const id = document.getElementById("book-id").value;
    const fileInput = document.getElementById("book-image-file");
    let finalImageUrl = "";

    const originalText = saveBtn.innerHTML;
    saveBtn.innerHTML =
      "<i class='bx bx-loader-alt bx-spin mr-2'></i> Saving...";
    saveBtn.disabled = true;

    try {
      // 1. Determine existing image URL if editing
      if (id) {
        const existingBook = window.booksData.find((b) => b.id === id);
        if (existingBook && existingBook.image_url) {
          finalImageUrl = existingBook.image_url;
        }
      }

      // 2. Upload new image to Supabase Storage (if a file was selected)
      if (fileInput.files.length > 0) {
        const file = fileInput.files[0];
        const fileExt = file.name.split(".").pop();
        // Generate a unique filename: timestamp + random string + extension
        const uniqueFileName = `${Date.now()}-${Math.random().toString(36).substring(2, 9)}.${fileExt}`;

        const { error: uploadError } = await supabaseClient.storage
          .from("book-covers")
          .upload(uniqueFileName, file, {
            cacheControl: "3600",
            upsert: false,
          });

        if (uploadError)
          throw new Error(`Image upload failed: ${uploadError.message}`);

        // Retrieve the public URL for the newly uploaded file
        const { data: publicUrlData } = supabaseClient.storage
          .from("book-covers")
          .getPublicUrl(uniqueFileName);

        finalImageUrl = publicUrlData.publicUrl;
      }

      // 3. Prepare data for database insertion
      const bookData = {
        title: document.getElementById("book-title").value.trim(),
        authors: document.getElementById("book-authors").value.trim(),
        description: document.getElementById("book-desc").value.trim(),
        publisher: document.getElementById("book-publisher").value.trim(),
        pub_year: document.getElementById("book-year").value.trim(),
        isbn: document.getElementById("book-isbn").value.trim(),
        image_url: finalImageUrl, // The new upload URL, or the preserved old one
        amazon_url: document.getElementById("book-amazon-url").value.trim(),
        publisher_url: document
          .getElementById("book-publisher-url")
          .value.trim(),
      };

      // 4. Save to Database
      let response;
      if (id) {
        response = await supabaseClient
          .from("books")
          .update(bookData)
          .eq("id", id);
      } else {
        response = await supabaseClient.from("books").insert([bookData]);
      }

      if (response.error) throw response.error;

      closeModal();
      await loadBooks();
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
  window.editBook = (id) => {
    const book = window.booksData.find((b) => b.id === id);
    if (!book) return;

    document.getElementById("book-id").value = book.id;
    document.getElementById("book-title").value = book.title || "";
    document.getElementById("book-authors").value = book.authors || "";
    document.getElementById("book-desc").value = book.description || "";
    document.getElementById("book-publisher").value = book.publisher || "";
    document.getElementById("book-year").value = book.pub_year || "";
    document.getElementById("book-isbn").value = book.isbn || "";
    // Note: We intentionally do not set the file input value here for security reasons.
    document.getElementById("book-image-file").value = "";
    document.getElementById("book-amazon-url").value = book.amazon_url || "";
    document.getElementById("book-publisher-url").value =
      book.publisher_url || "";

    openModal(true);
  };

  window.deleteBook = async (id) => {
    if (
      !confirm(
        "Are you sure you want to delete this book? This action triggers a live site rebuild.",
      )
    )
      return;

    try {
      const { error } = await supabaseClient
        .from("books")
        .delete()
        .eq("id", id);
      if (error) throw error;
      await loadBooks();
    } catch (err) {
      console.error("Delete error:", err);
      alert("Failed to delete: " + err.message);
    }
  };

  // --- INIT ---
  loadBooks();
});
