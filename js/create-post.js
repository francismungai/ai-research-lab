/**
 * Create Post Editor Logic
 * Handles markdown editing, live preview, saving drafts, and publishing.
 */
document.addEventListener("DOMContentLoaded", async () => {
  // --- Auth Guard: Redirect if not logged in ---
  let currentUser = null;
  try {
    const {
      data: { session },
    } = await supabaseClient.auth.getSession();
    if (!session) {
      window.location.href = "login.html";
      return;
    }
    currentUser = session.user;
  } catch (e) {
    window.location.href = "login.html";
    return;
  }

  // --- DOM Elements ---
  const titleInput = document.getElementById("post-title");
  const excerptInput = document.getElementById("post-excerpt");
  const tagsInput = document.getElementById("post-tags");
  const coverUrlInput = document.getElementById("post-cover-url");
  const contentArea = document.getElementById("post-content");
  const previewContent = document.getElementById("preview-content");
  const saveStatus = document.getElementById("save-status");

  const tabWrite = document.getElementById("tab-write");
  const tabPreview = document.getElementById("tab-preview");
  const tabSplit = document.getElementById("tab-split");
  const panelWrite = document.getElementById("panel-write");
  const panelPreview = document.getElementById("panel-preview");

  const btnSaveDraft = document.getElementById("btn-save-draft");
  const btnPublish = document.getElementById("btn-publish");

  // --- Check if editing existing post (via ?id= query param) ---
  const urlParams = new URLSearchParams(window.location.search);
  const editingPostId = urlParams.get("id");
  let currentPostId = editingPostId;

  if (editingPostId) {
    await loadExistingPost(editingPostId);
  }

  // --- Tab Switching ---
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

  // --- Live Preview ---
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

  // Update preview on content change (debounced)
  let previewTimeout;
  contentArea.addEventListener("input", () => {
    // Update save status
    saveStatus.innerHTML =
      '<i class="bx bx-cloud text-sm mr-1"></i>Unsaved changes';
    saveStatus.classList.remove("text-green-500");
    saveStatus.classList.add("text-amber-500");

    // Debounced preview update
    clearTimeout(previewTimeout);
    previewTimeout = setTimeout(() => {
      if (!panelPreview.classList.contains("hidden")) {
        updatePreview();
      }
    }, 300);
  });

  // --- Slug Generator ---
  function generateSlug(title) {
    return title
      .toLowerCase()
      .replace(/[^a-z0-9\s-]/g, "")
      .replace(/\s+/g, "-")
      .replace(/-+/g, "-")
      .replace(/^-|-$/g, "")
      .substring(0, 80);
  }

  // --- Gather Post Data ---
  function getPostData(status) {
    const title = titleInput.value.trim();
    const content = contentArea.value;
    const excerpt = excerptInput.value.trim();
    const coverUrl = coverUrlInput.value.trim();
    const tagsRaw = tagsInput.value.trim();
    const tags = tagsRaw
      ? tagsRaw
          .split(",")
          .map((t) => t.trim())
          .filter(Boolean)
      : [];

    if (!title) {
      showToast("Please enter a post title.", "error");
      return null;
    }

    const slug = generateSlug(title);
    if (!slug) {
      showToast("Title must contain at least one valid character.", "error");
      return null;
    }

    const postData = {
      title,
      slug,
      content,
      excerpt,
      cover_image_url: coverUrl || null,
      tags,
      status,
      author_id: currentUser.id,
      author_name: currentUser.email,
      updated_at: new Date().toISOString(),
    };

    if (status === "published") {
      postData.published_at = new Date().toISOString();
    }

    return postData;
  }

  // --- Save Draft ---
  btnSaveDraft.addEventListener("click", async () => {
    const postData = getPostData("draft");
    if (!postData) return;

    btnSaveDraft.disabled = true;
    btnSaveDraft.textContent = "Saving...";

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
        result = await supabaseClient
          .from("blog_posts")
          .insert(postData)
          .select()
          .single();
      }

      if (result.error) {
        // Handle duplicate slug
        if (result.error.code === "23505") {
          showToast(
            "A post with this title already exists. Try a different title.",
            "error",
          );
        } else {
          showToast("Error saving: " + result.error.message, "error");
        }
      } else {
        currentPostId = result.data.id;
        // Update URL without reload
        if (!editingPostId) {
          window.history.replaceState(
            {},
            "",
            `create-post.html?id=${currentPostId}`,
          );
        }
        saveStatus.innerHTML =
          '<i class="bx bx-cloud-upload text-sm mr-1"></i>Draft saved';
        saveStatus.classList.remove("text-amber-500");
        saveStatus.classList.add("text-green-500");
        showToast("Draft saved!", "success");
      }
    } catch (err) {
      showToast("Error saving draft.", "error");
      console.error(err);
    }

    btnSaveDraft.disabled = false;
    btnSaveDraft.textContent = "Save Draft";
  });

  // --- Publish ---
  btnPublish.addEventListener("click", async () => {
    const postData = getPostData("published");
    if (!postData) return;

    if (!postData.content.trim()) {
      showToast("Please write some content before publishing.", "error");
      return;
    }

    btnPublish.disabled = true;
    btnPublish.textContent = "Publishing...";

    try {
      let result;
      if (currentPostId) {
        result = await supabaseClient
          .from("blog_posts")
          .update(postData)
          .eq("id", currentPostId)
          .select()
          .single();
      } else {
        result = await supabaseClient
          .from("blog_posts")
          .insert(postData)
          .select()
          .single();
      }

      if (result.error) {
        if (result.error.code === "23505") {
          showToast(
            "A post with this title already exists. Try a different title.",
            "error",
          );
        } else {
          showToast("Error publishing: " + result.error.message, "error");
        }
      } else {
        showToast("Post published! Redirecting...", "success");
        setTimeout(() => {
          window.location.href = "blog.html";
        }, 1500);
        return;
      }
    } catch (err) {
      showToast("Error publishing post.", "error");
      console.error(err);
    }

    btnPublish.disabled = false;
    btnPublish.textContent = "Publish";
  });

  // --- Load Existing Post (for editing) ---
  async function loadExistingPost(postId) {
    try {
      const { data: post, error } = await supabaseClient
        .from("blog_posts")
        .select("*")
        .eq("id", postId)
        .single();

      if (error || !post) {
        showToast("Could not load post.", "error");
        return;
      }

      titleInput.value = post.title || "";
      excerptInput.value = post.excerpt || "";
      tagsInput.value = (post.tags || []).join(", ");
      coverUrlInput.value = post.cover_image_url || "";
      contentArea.value = post.content || "";

      saveStatus.innerHTML =
        '<i class="bx bx-cloud-upload text-sm mr-1"></i>Loaded';
      saveStatus.classList.add("text-green-500");
    } catch (err) {
      console.error("Error loading post:", err);
    }
  }

  // --- Keyboard Shortcut: Ctrl+S to save draft ---
  document.addEventListener("keydown", (e) => {
    if ((e.ctrlKey || e.metaKey) && e.key === "s") {
      e.preventDefault();
      btnSaveDraft.click();
    }
  });
});
