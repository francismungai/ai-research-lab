/**
 * Blog Page Logic
 * Fetches published blog posts from Supabase and renders them as cards.
 * Shows "Write Post" button for authenticated users.
 */
document.addEventListener("DOMContentLoaded", async () => {
  const postsGrid = document.getElementById("blog-posts-grid");
  const emptyState = document.getElementById("blog-empty-state");
  const writeBtn = document.getElementById("write-post-btn");
  const loadingState = document.getElementById("blog-loading");

  // Show "Write Post" button if user is logged in
  try {
    const {
      data: { session },
    } = await supabaseClient.auth.getSession();
    if (session && writeBtn) {
      writeBtn.classList.remove("hidden");
    }
  } catch (e) {
    // Not logged in — that's fine
  }

  // Fetch published posts
  try {
    const { data: posts, error } = await supabaseClient
      .from("blog_posts")
      .select("*")
      .eq("status", "published")
      .order("published_at", { ascending: false });

    // Hide loading
    if (loadingState) loadingState.classList.add("hidden");

    if (error) {
      console.error("Error fetching posts:", error);
      if (emptyState) emptyState.classList.remove("hidden");
      return;
    }

    if (!posts || posts.length === 0) {
      if (emptyState) emptyState.classList.remove("hidden");
      return;
    }

    // Render posts
    if (postsGrid) {
      postsGrid.classList.remove("hidden");
      postsGrid.innerHTML = posts.map((post) => renderPostCard(post)).join("");
    }
  } catch (err) {
    console.error("Blog fetch error:", err);
    if (loadingState) loadingState.classList.add("hidden");
    if (emptyState) emptyState.classList.remove("hidden");
  }
});

/**
 * Renders a single blog post card.
 */
function renderPostCard(post) {
  const date = post.published_at
    ? new Date(post.published_at).toLocaleDateString("en-US", {
        year: "numeric",
        month: "long",
        day: "numeric",
      })
    : "";

  const tagsHtml = (post.tags || [])
    .slice(0, 3)
    .map(
      (tag) =>
        `<span class="inline-block px-2 py-0.5 bg-red-50 text-[#C53030] text-[10px] font-bold rounded-full border border-red-100">${tag}</span>`,
    )
    .join("");

  const excerpt = post.excerpt || "";

  // --- LOCAL ASSETS ROUTING WITH CLOUD FALLBACK ---
  let coverHtml = "";
  if (post.cover_image_url) {
    // 1. Extract the filename from the end of the Supabase URL
    const filename = post.cover_image_url.split("/").pop();
    // 2. Build the local path relative to the public HTML file
    const localImagePath = `assets/blog/${filename}`;

    // 3. Render the image. If the local file fails to load, fallback to the cloud URL!
    coverHtml = `
      <div class="h-44 overflow-hidden">
         <img 
            src="${localImagePath}" 
            onerror="this.onerror=null; this.src='${post.cover_image_url}';" 
            alt="${post.title}" 
            class="w-full h-full object-cover group-hover:scale-105 transition-transform duration-500" 
         />
       </div>`;
  } else {
    // Default placeholder if no cover image exists
    coverHtml = `
      <div class="h-44 bg-linear-to-br from-red-50 to-gray-100 flex items-center justify-center">
         <i class="bx bx-file-blank text-5xl text-gray-300"></i>
       </div>`;
  }

  return `
    <a href="blog-post.html?slug=${post.slug}" class="group bg-white border border-gray-200 rounded-2xl overflow-hidden shadow-sm hover:shadow-xl hover:border-[#C53030] transition-all duration-300 flex flex-col">
      ${coverHtml}
      <div class="p-5 flex flex-col flex-1">
        <div class="flex items-center gap-2 mb-3 flex-wrap">
          ${tagsHtml}
        </div>
        <h3 class="text-lg font-bold text-gray-900 mb-2 group-hover:text-[#C53030] transition-colors line-clamp-2 leading-snug">
          ${post.title}
        </h3>
        <p class="text-sm text-gray-600 font-medium mb-4 line-clamp-3 flex-1">
          ${excerpt}
        </p>
        <div class="flex items-center justify-between text-xs text-gray-500 pt-3 border-t border-gray-100 mt-auto">
          <span class="font-bold">${post.author_name || "Unknown"}</span>
          <span class="font-medium">${date}</span>
        </div>
      </div>
    </a>
  `;
}
