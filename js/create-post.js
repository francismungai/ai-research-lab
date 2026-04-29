/**
 * Create Post Editor Logic
 * Handles markdown editing, live preview, role-based saving, and publishing.
 */
document.addEventListener("DOMContentLoaded", async () => {
  // --- 1. AUTH GUARD & ROLE CHECK ---
  let currentUser = null;
  let userRole = "user";

  try {
    const {
      data: { session },
    } = await supabaseClient.auth.getSession();
    if (!session) {
      window.location.replace("../login.html");
      return;
    }
    currentUser = session.user;

    // Fetch role to know if they are allowed to publish directly
    const { data: profile } = await supabaseClient
      .from("profiles")
      .select("role")
      .eq("id", currentUser.id)
      .single();

    if (profile) userRole = profile.role;

    // Uncloak the page
    document.body.style.display = "flex";
  } catch (e) {
    window.location.replace("../login.html");
    return;
  }

  // --- 2. DOM ELEMENTS ---
  const titleInput = document.getElementById("post-title");
  const slugInput = document.getElementById("post-slug");
  const excerptInput = document.getElementById("post-excerpt");
  const coverUrlInput = document.getElementById("post-cover-url");
  const statusSelect = document.getElementById("post-status");
  const contentArea = document.getElementById("post-content");
  const previewContent = document.getElementById("preview-content");
  const saveStatus = document.getElementById("save-status");
  const btnSave = document.getElementById("btn-save");

  // Tabs & Panels
  const tabWrite = document.getElementById("tab-write");
  const tabPreview = document.getElementById("tab-preview");
  const tabSplit = document.getElementById("tab-split");
  const panelWrite = document.getElementById("panel-write");
  const panelPreview = document.getElementById("panel-preview");

  // Lock the "Published" option for regular students (Contributors)
  if (userRole === "contributor") {
    const publishedOption = statusSelect.querySelector(
      'option[value="published"]',
    );
    if (publishedOption) publishedOption.disabled = true;
  }

  // --- 3. LOAD EXISTING DATA (IF EDITING) ---
  const urlParams = new URLSearchParams(window.location.search);
  const editingPostId = urlParams.get("id");
  let currentPostId = editingPostId;

  if (editingPostId) {
    await loadExistingPost(editingPostId);
  }

  // --- 4. TAB SWITCHING (From your original JS) ---
  function setActiveTab(activeTab) {
    const tabs = [tabWrite, tabPreview, tabSplit];
    tabs.forEach((tab) => {
      if (tab) {
        tab.classList.remove("border-[#C53030]", "text-[#C53030]");
        tab.classList.add("border-transparent", "text-gray-500");
      }
    });
    activeTab.classList.remove("border-transparent", "text-gray-500");
    activeTab.classList.add("border-[#C53030]", "text-[#C53030]");
  }

  tabWrite.addEventListener("click", () => {
    setActiveTab(tabWrite);
    panelWrite.classList.remove("hidden");
    panelPreview.classList.add("hidden");
    panelWrite.classList.remove("w-1/2");
    panelWrite.classList.add("flex-1");
  });

  tabPreview.addEventListener("click", () => {
    setActiveTab(tabPreview);
    panelWrite.classList.add("hidden");
    panelPreview.classList.remove("hidden");
    panelPreview.classList.add("flex-1");
    panelPreview.classList.remove("w-1/2");
    updatePreview();
  });

  if (tabSplit) {
    tabSplit.addEventListener("click", () => {
      setActiveTab(tabSplit);
      panelWrite.classList.remove("hidden", "flex-1");
      panelPreview.classList.remove("hidden", "flex-1");
      panelWrite.classList.add("w-1/2");
      panelPreview.classList.add("w-1/2");
      updatePreview();
    });
  }

  // --- 5. LIVE PREVIEW WITH DEBOUNCE (From your original JS) ---
  function updatePreview() {
    const markdown = contentArea.value;
    if (!markdown.trim()) {
      previewContent.innerHTML =
        '<p class="text-gray-400 italic">Start writing to see your preview here...</p>';
      return;
    }
    try {
      previewContent.innerHTML = marked.parse(markdown);
    } catch (e) {
      previewContent.innerHTML = `<p class="text-red-500">Error parsing markdown</p>`;
    }
  }

  let previewTimeout;
  contentArea.addEventListener("input", () => {
    saveStatus.innerHTML =
      '<i class="bx bx-cloud text-sm mr-1"></i>Unsaved changes';
    saveStatus.classList.remove("text-green-500");
    saveStatus.classList.add("text-amber-500");

    clearTimeout(previewTimeout);
    previewTimeout = setTimeout(() => {
      if (!panelPreview.classList.contains("hidden")) {
        updatePreview();
      }
    }, 300);
  });

  // --- 6. AUTO-GENERATE SLUG ---
  function generateSlug(title) {
    return title
      .toLowerCase()
      .replace(/[^a-z0-9\s-]/g, "")
      .replace(/\s+/g, "-")
      .replace(/-+/g, "-")
      .replace(/^-|-$/g, "")
      .substring(0, 80);
  }

  titleInput.addEventListener("input", (e) => {
    // Only auto-generate if we haven't saved the post yet
    if (!currentPostId) {
      slugInput.value = generateSlug(e.target.value);
    }
  });

  // --- 7. SAVE / PUBLISH LOGIC ---
  btnSave.addEventListener("click", async () => {
    const title = titleInput.value.trim();
    const slug = slugInput.value.trim();
    const content = contentArea.value.trim();
    const status = statusSelect.value;

    if (!title || !slug || !content) {
      if (typeof showToast === "function")
        showToast("Title, Slug, and Content are required.", "error");
      else alert("Title, Slug, and Content are required.");
      return;
    }

    const postData = {
      title: title,
      slug: slug,
      excerpt: excerptInput.value.trim(),
      content: content,
      cover_image_url: coverUrlInput.value.trim() || null,
      status: status,
      updated_at: new Date().toISOString(),
    };

    if (status === "published") {
      postData.published_at = new Date().toISOString();
    }

    const originalHtml = btnSave.innerHTML;
    btnSave.innerHTML =
      "<i class='bx bx-loader-alt bx-spin mr-2 text-lg'></i> Saving...";
    btnSave.disabled = true;

    try {
      let result;
      if (currentPostId) {
        // Update existing post
        result = await supabaseClient
          .from("blog_posts")
          .update(postData)
          .eq("id", currentPostId)
          .select()
          .single();
      } else {
        // Insert new post
        postData.author_name = currentUser.email.split("@")[0]; // Simple default
        result = await supabaseClient
          .from("blog_posts")
          .insert(postData)
          .select()
          .single();
      }

      if (result.error) {
        if (result.error.code === "23505") {
          if (typeof showToast === "function")
            showToast("A post with this URL slug already exists.", "error");
        } else {
          if (typeof showToast === "function")
            showToast("Error saving: " + result.error.message, "error");
        }
      } else {
        currentPostId = result.data.id;

        if (!editingPostId) {
          window.history.replaceState(
            {},
            "",
            `create-post.html?id=${currentPostId}`,
          );
        }

        saveStatus.innerHTML =
          '<i class="bx bx-check-circle text-sm mr-1"></i>Saved';
        saveStatus.classList.remove("text-amber-500");
        saveStatus.classList.add("text-green-500");

        const successMsg =
          status === "published"
            ? "Post published live!"
            : "Draft saved securely.";
        if (typeof showToast === "function") showToast(successMsg, "success");
      }
    } catch (err) {
      console.error(err);
      if (typeof showToast === "function")
        showToast("Critical error saving post.", "error");
    } finally {
      btnSave.innerHTML = originalHtml;
      btnSave.disabled = false;
    }
  });

  // --- 8. LOAD EXISTING POST (HELPER) ---
  async function loadExistingPost(postId) {
    try {
      const { data: post, error } = await supabaseClient
        .from("blog_posts")
        .select("*")
        .eq("id", postId)
        .single();

      if (error || !post) {
        if (typeof showToast === "function")
          showToast("Could not load post.", "error");
        return;
      }

      titleInput.value = post.title || "";
      slugInput.value = post.slug || "";
      excerptInput.value = post.excerpt || "";
      coverUrlInput.value = post.cover_image_url || "";
      contentArea.value = post.content || "";
      statusSelect.value = post.status || "draft";

      saveStatus.innerHTML =
        '<i class="bx bx-cloud-upload text-sm mr-1"></i>Loaded';
      saveStatus.classList.add("text-green-500");

      updatePreview();
    } catch (err) {
      console.error("Error loading post:", err);
    }
  }

  // --- 9. KEYBOARD SHORTCUT: Ctrl+S ---
  document.addEventListener("keydown", (e) => {
    if ((e.ctrlKey || e.metaKey) && e.key === "s") {
      e.preventDefault();
      btnSave.click();
    }
  });
});
