/**
 * Blog Post Reading Logic
 * Fetches a single published post based on the URL slug and renders the Markdown.
 */
document.addEventListener("DOMContentLoaded", async () => {
  // --- 1. DOM ELEMENTS ---
  const loadingState = document.getElementById("post-loading");
  const errorState = document.getElementById("post-error");
  const postContainer = document.getElementById("post-container");

  const titleEl = document.getElementById("post-title");
  const authorEl = document.getElementById("post-author");
  const dateEl = document.getElementById("post-date");
  const tagsEl = document.getElementById("post-tags");
  const coverContainer = document.getElementById("post-cover-container");
  const coverImage = document.getElementById("post-cover-image");
  const contentEl = document.getElementById("post-content");

  // --- 2. GET SLUG FROM URL ---
  const urlParams = new URLSearchParams(window.location.search);
  const slug = urlParams.get("slug");

  if (!slug) {
    showError();
    return;
  }

  try {
    // --- 3. FETCH POST FROM SUPABASE ---
    const { data: post, error } = await supabaseClient
      .from("blog_posts")
      .select("*")
      .eq("slug", slug)
      .eq("status", "published") // Only allow public users to see published posts
      .single();

    if (error || !post) {
      console.error("Error fetching post:", error);
      showError();
      return;
    }

    // --- 4. POPULATE UI ---

    // Update the browser tab title
    document.title = `${post.title} | USD AI Research`;

    titleEl.textContent = post.title;
    authorEl.textContent = post.author_name || "Unknown Author";

    // Format the date
    const publishDate = post.published_at
      ? new Date(post.published_at)
      : new Date(post.updated_at);
    dateEl.textContent = publishDate.toLocaleDateString("en-US", {
      year: "numeric",
      month: "long",
      day: "numeric",
    });

    // Render Tags (if any exist)
    if (post.tags && post.tags.length > 0) {
      tagsEl.innerHTML = post.tags
        .map(
          (tag) =>
            `<span class="px-3 py-1 bg-red-50 text-[#C53030] text-xs font-bold rounded-full border border-red-100 uppercase tracking-wider">${tag}</span>`,
        )
        .join("");
    } else {
      tagsEl.innerHTML = "";
    }

    // --- 5. HANDLE COVER IMAGE (Local + Fallback) ---
    if (post.cover_image_url) {
      const filename = post.cover_image_url.split("/").pop();
      const localImagePath = `assets/blog/${filename}`;

      // Set the source to the local file first
      coverImage.src = localImagePath;

      // If the local file 404s (e.g., GitHub hasn't built it yet), fallback to cloud!
      coverImage.onerror = () => {
        coverImage.onerror = null; // Prevent infinite loop if cloud URL also fails
        coverImage.src = post.cover_image_url;
      };

      coverContainer.classList.remove("hidden");
    } else {
      // Hide the big image container entirely if the post has no cover photo
      coverContainer.classList.add("hidden");
    }

    // --- 6. RENDER MARKDOWN ---
    if (post.content) {
      // marked.parse() safely converts the markdown string into formatted HTML
      contentEl.innerHTML = marked.parse(post.content);
    } else {
      contentEl.innerHTML =
        "<p class='text-gray-500 italic'>No content available.</p>";
    }

    // --- 7. SHOW CONTENT ---
    loadingState.classList.add("hidden");
    postContainer.classList.remove("hidden");
    postContainer.classList.add("flex"); // We used flex-col in HTML, so we restore flex
  } catch (err) {
    console.error("Critical error loading post:", err);
    showError();
  }

  // --- HELPER FUNCTION ---
  function showError() {
    loadingState.classList.add("hidden");
    errorState.classList.remove("hidden");
    errorState.classList.add("flex");
  }
});
