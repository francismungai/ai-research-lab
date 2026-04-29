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
  const tableBody = document.getElementById("blogs-table-body");

  // --- 3. FETCH & RENDER DATA ---
  async function loadBlogs() {
    const { data, error } = await supabaseClient
      .from("blog_posts")
      .select("*")
      .order("updated_at", { ascending: false });

    if (error) {
      console.error("Error fetching blogs:", error);
      tableBody.innerHTML = `<tr><td colspan="4" class="p-4 text-center text-red-500">Failed to load data.</td></tr>`;
      return;
    }

    if (data.length === 0) {
      tableBody.innerHTML = `<tr><td colspan="4" class="p-4 text-center text-gray-500">No blog posts found.</td></tr>`;
      return;
    }

    tableBody.innerHTML = data
      .map((post) => {
        // Status Badge Styling
        let statusBadge = "";
        let approveBtn = "";

        if (post.status === "published") {
          statusBadge =
            '<span class="px-2 py-1 rounded-full text-xs font-semibold bg-green-100 text-green-800">Published</span>';
        } else if (post.status === "in_review") {
          statusBadge =
            '<span class="px-2 py-1 rounded-full text-xs font-semibold bg-yellow-100 text-yellow-800">In Review</span>';
          // Add quick-approve button for in_review posts
          approveBtn = `<button onclick="approveBlog('${post.id}')" title="Approve & Publish" class="text-green-600 hover:text-green-800 p-1 mx-1 transition"><i class='bx bx-check-circle text-xl'></i></button>`;
        } else {
          statusBadge =
            '<span class="px-2 py-1 rounded-full text-xs font-semibold bg-gray-200 text-gray-800">Draft</span>';
        }

        // Date formatting
        const dateString = post.published_at
          ? new Date(post.published_at).toLocaleDateString()
          : `Updated: ${new Date(post.updated_at).toLocaleDateString()}`;

        return `
      <tr class="hover:bg-gray-50 transition border-b border-gray-100 last:border-0">
        <td class="p-4">
          <p class="text-sm font-bold text-gray-900">${post.title}</p>
          <p class="text-xs text-gray-500 mt-1">By: ${post.author_name || "Unknown"}</p>
        </td>
        <td class="p-4 text-sm">${statusBadge}</td>
        <td class="p-4 text-sm text-gray-600">${dateString}</td>
        <td class="p-4 text-right whitespace-nowrap flex justify-end items-center">
          ${approveBtn}
          <button onclick="editBlog('${post.id}')" title="Edit" class="text-blue-600 hover:text-blue-800 p-1 mx-1 transition"><i class='bx bx-edit text-lg'></i></button>
          <button onclick="deleteBlog('${post.id}')" title="Delete" class="text-red-500 hover:text-red-700 p-1 mx-1 transition"><i class='bx bx-trash text-lg'></i></button>
        </td>
      </tr>
    `;
      })
      .join("");
  }

  // --- 4. GLOBAL HELPER FUNCTIONS ---

  // Route to editor with the post ID
  window.editBlog = (id) => {
    window.location.href = `create-post.html?id=${id}`;
  };

  window.approveBlog = async (id) => {
    if (!confirm("Are you sure you want to approve and publish this post?"))
      return;

    try {
      const { error } = await supabaseClient
        .from("blog_posts")
        .update({
          status: "published",
          published_at: new Date().toISOString(),
          updated_at: new Date().toISOString(),
        })
        .eq("id", id);

      if (error) throw error;
      await loadBlogs();
    } catch (err) {
      console.error("Approval error:", err);
      alert("Failed to approve: " + err.message);
    }
  };

  window.deleteBlog = async (id) => {
    if (!confirm("Are you sure you want to delete this blog post?")) return;

    try {
      const { error } = await supabaseClient
        .from("blog_posts")
        .delete()
        .eq("id", id);
      if (error) throw error;
      await loadBlogs();
    } catch (err) {
      console.error("Delete error:", err);
      alert("Failed to delete: " + err.message);
    }
  };

  // --- INIT ---
  loadBlogs();
});
