// scripts/download-assets.js
const { createClient } = require("@supabase/supabase-js");
const fs = require("fs");
const path = require("path");

const supabaseUrl = process.env.SUPABASE_URL;
const supabaseKey = process.env.SUPABASE_ANON_KEY;

if (!supabaseUrl || !supabaseKey) {
  console.error("Missing Supabase credentials in environment.");
  process.exit(1);
}

const supabase = createClient(supabaseUrl, supabaseKey);

async function downloadCovers() {
  // 1. Fetch only books that actually have an image URL
  const { data: books, error } = await supabase
    .from("books")
    .select("image_url")
    .not("image_url", "is", null);

  if (error) {
    console.error("Error fetching books:", error);
    process.exit(1);
  }

  // 2. Ensure the local assets/books directory exists
  const dir = path.join(__dirname, "../assets/books");
  if (!fs.existsSync(dir)) fs.mkdirSync(dir, { recursive: true });

  // 3. Process each book
  for (const book of books) {
    // Check if the URL is a Supabase storage URL to avoid trying to download external placeholder links
    if (
      book.image_url.includes(
        "supabase.co/storage/v1/object/public/book-covers/",
      )
    ) {
      // Extract just the filename from the end of the URL
      const filename = book.image_url.split("/").pop();
      const filePath = path.join(dir, filename);

      // THE CACHE CHECK: If it exists, skip it!
      if (fs.existsSync(filePath)) {
        console.log(`Skipping: ${filename} (Already cached)`);
        continue;
      }

      // Otherwise, download the new image
      console.log(`Downloading: ${filename}...`);
      const { data, error: downloadError } = await supabase.storage
        .from("book-covers")
        .download(filename);

      if (downloadError) {
        console.error(`Failed to download ${filename}:`, downloadError);
        continue; // Skip to the next one if it fails
      }

      // Save to the local assets folder
      const buffer = Buffer.from(await data.arrayBuffer());
      fs.writeFileSync(filePath, buffer);
      console.log(`Saved: ${filename}`);
    }
  }
}

downloadCovers();
