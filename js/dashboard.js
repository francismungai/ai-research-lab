document.addEventListener("DOMContentLoaded", async () => {
  // Ensure the user is authenticated before attempting to fetch stats
  const {
    data: { session },
  } = await supabaseClient.auth.getSession();
  if (!session) return;

  const statDrafts = document.getElementById("stat-drafts");
  const statPubs = document.getElementById("stat-pubs");
  const statMembers = document.getElementById("stat-members");

  // 1. Fetch Drafts Count
  if (statDrafts) {
    const { count, error } = await supabaseClient
      .from("blog_posts")
      .select("*", { count: "exact", head: true })
      .eq("status", "draft");

    if (!error) statDrafts.textContent = count;
  }

  // 2. Fetch Publications Count
  if (statPubs) {
    const { count, error } = await supabaseClient
      .from("publications")
      .select("*", { count: "exact", head: true });

    if (!error) statPubs.textContent = count;
  }

  // 3. Fetch People Count
  if (statMembers) {
    const { count, error } = await supabaseClient
      .from("people")
      .select("*", { count: "exact", head: true });

    if (!error) statMembers.textContent = count;
  }
});
