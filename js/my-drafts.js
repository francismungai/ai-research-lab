document.addEventListener("DOMContentLoaded", async () => {
  // --- 1. AUTH CHECK ---
  const {
    data: { session },
  } = await supabaseClient.auth.getSession();
  if (!session) return; // portal.js handles redirect

  // --- 2. DOM ELEMENTS ---
  const tableBody = document.getElementById("my-drafts-table-body");
  const writePostBtn = document.getElementById("write-post-btn");

  writePostBtn.addEventListener("click", () => {
    window.location.href = "create-post.html";
  });

  // --- 3. FETCH PERSONAL DATA ---
  async function loadMyDrafts() {
    const { data, error } = await supabaseClient
      .from("blog_posts")
      .select("*")
      .eq("author_id", session.user.id)
      .order("updated_at", { ascending: false });

    if (error) {
      console.error("Error fetching personal drafts:", error);
      tableBody.innerHTML = `<tr><td colspan="4" class="p-4 text-center text-red-500">Failed to load your posts.</td></tr>`;
      return;
    }

    if (data.length === 0) {
      tableBody.innerHTML = `<tr><td colspan="4" class="p-4 text-center text-gray-500">You haven't written any posts yet.</td></tr>`;
      return;
    }

    tableBody.innerHTML = data
      .map((post) => {
        let statusBadge = "";
        if (post.status === "published") {
          statusBadge =
            '<span class="px-2 py-1 rounded-full text-xs font-semibold bg-green-100 text-green-800">Published</span>';
        } else if (post.status === "in_review") {
          statusBadge =
            '<span class="px-2 py-1 rounded-full text-xs font-semibold bg-yellow-100 text-yellow-800">In Review</span>';
        } else {
          statusBadge =
            '<span class="px-2 py-1 rounded-full text-xs font-semibold bg-gray-200 text-gray-800">Draft</span>';
        }

        const dateString = new Date(post.updated_at).toLocaleDateString();

        return `
      <tr class="hover:bg-gray-50 transition border-b border-gray-100 last:border-0">
        <td class="p-4 text-sm font-bold text-gray-900">${post.title}</td>
        <td class="p-4 text-sm">${statusBadge}</td>
        <td class="p-4 text-sm text-gray-600">${dateString}</td>
        <td class="p-4 text-right whitespace-nowrap">
          <button onclick="editMyPost('${post.id}')" title="Edit" class="text-blue-600 hover:text-blue-800 p-1 mx-1 transition"><i class='bx bx-edit text-lg'></i></button>
          <button onclick="deleteMyPost('${post.id}')" title="Delete" class="text-red-500 hover:text-red-700 p-1 mx-1 transition"><i class='bx bx-trash text-lg'></i></button>
        </td>
      </tr>
    `;
      })
      .join("");
  }

  // --- 4. HELPER FUNCTIONS ---
  window.editMyPost = (id) => {
    window.location.href = `create-post.html?id=${id}`;
  };

  window.deleteMyPost = async (id) => {
    if (!confirm("Are you sure you want to delete this post?")) return;

    try {
      const { error } = await supabaseClient
        .from("blog_posts")
        .delete()
        .eq("id", id);
      if (error) throw error;
      await loadMyDrafts();
    } catch (err) {
      console.error("Delete error:", err);
      alert("Failed to delete post.");
    }
  };

  loadMyDrafts();
});
