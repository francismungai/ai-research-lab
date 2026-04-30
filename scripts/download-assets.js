// scripts/download-assets.js
import { createClient } from "@supabase/supabase-js";
import fs from "fs";
import path from "path";

const supabaseUrl = process.env.SUPABASE_URL;
const supabaseKey = process.env.SUPABASE_ANON_KEY;

if (!supabaseUrl || !supabaseKey) {
  console.error("Missing Supabase credentials in environment.");
  process.exit(1);
}

const supabase = createClient(supabaseUrl, supabaseKey);

// --- ASSET CONFIGURATION ---
const ASSET_CONFIGS = [
  {
    tableName: "books",
    urlColumn: "image_url",
    bucketName: "book-covers",
    localPath: "assets/books", // Relative to project root
  },
  {
    tableName: "people",
    urlColumn: "photo_url",
    bucketName: "people-photos",
    localPath: "assets/people", // Relative to project root
  },
  {
    tableName: "blog_posts",
    urlColumn: "cover_image_url",
    bucketName: "blog-covers",
    localPath: "assets/blog", // Relative to project root
  },
];

async function downloadAllAssets() {
  for (const config of ASSET_CONFIGS) {
    console.log(`\n--- Processing ${config.tableName} ---`);

    // 1. Fetch only records that actually have an image URL
    const { data: records, error } = await supabase
      .from(config.tableName)
      .select(config.urlColumn)
      .not(config.urlColumn, "is", null);

    if (error) {
      console.error(`Error fetching ${config.tableName}:`, error);
      continue; // Skip to the next config if this one fails
    }

    // 2. Ensure the local directory exists using process.cwd() for ESM compatibility
    const dir = path.join(process.cwd(), config.localPath);
    if (!fs.existsSync(dir)) fs.mkdirSync(dir, { recursive: true });

    // 3. Process each record
    for (const record of records) {
      const fileUrl = record[config.urlColumn];

      // Check if the URL is a Supabase storage URL to avoid downloading external placeholders
      if (
        fileUrl &&
        fileUrl.includes(
          `supabase.co/storage/v1/object/public/${config.bucketName}/`,
        )
      ) {
        // Extract just the filename from the end of the URL
        const filename = fileUrl.split("/").pop();
        const filePath = path.join(dir, filename);

        // THE CACHE CHECK: If it exists, skip it!
        if (fs.existsSync(filePath)) {
          console.log(`Skipping: ${filename} (Already cached)`);
          continue;
        }

        // Otherwise, download the new image
        console.log(`Downloading: ${filename}...`);
        const { data, error: downloadError } = await supabase.storage
          .from(config.bucketName)
          .download(filename);

        if (downloadError) {
          console.error(`Failed to download ${filename}:`, downloadError);
          continue;
        }

        // Save to the local assets folder
        const buffer = Buffer.from(await data.arrayBuffer());
        fs.writeFileSync(filePath, buffer);
        console.log(`Saved: ${filename}`);
      }
    }
  }
  console.log("\nAll asset downloads complete!");
}

downloadAllAssets();
