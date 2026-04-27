import { createClient } from "@supabase/supabase-js";
import fs from "fs";
import path from "path";

const supabase = createClient(
  process.env.SUPABASE_URL,
  process.env.SUPABASE_ANON_KEY,
);

async function buildPeoplePage() {
  console.log("Fetching people from Supabase...");

  const { data: people, error } = await supabase
    .from("people")
    .select("*")
    .order("name");

  if (error) {
    console.error("Error fetching people:", error);
    process.exit(1);
  }

  let cardsHtml = "";

  people.forEach((person) => {
    // Determine the image markup based on if they have a photo
    const imageHtml = person.photo_url
      ? `<img src="${person.photo_url}" alt="${person.name}" class="w-full h-full object-cover ${person.name.includes("Rizk") ? "object-top" : ""}" />`
      : `<div class="w-full h-full bg-gray-50 flex items-center justify-center group-hover:bg-red-50 transition-colors duration-300">
           <i class="bx bx-user text-4xl text-gray-300 group-hover:text-[#C53030]"></i>
         </div>`;

    // Determine footer links (Scholar / DBLP)
    let linksHtml = "";
    if (person.scholar_url || person.dblp_url) {
      const scholarHtml = person.scholar_url
        ? `<a href="${person.scholar_url}" target="_blank" class="text-blue-600 hover:text-blue-800 transition-colors inline-flex items-center"><i class="bx bxl-google mr-1"></i> Scholar</a>`
        : "";
      const separatorHtml =
        person.scholar_url && person.dblp_url
          ? `<span class="text-gray-300">|</span>`
          : "";
      const dblpHtml = person.dblp_url
        ? `<a href="${person.dblp_url}" target="_blank" class="text-orange-600 hover:text-orange-800 transition-colors inline-flex items-center"><i class="bx bx-library mr-1"></i> DBLP</a>`
        : "";

      linksHtml = `
        <div class="mt-auto flex gap-3 text-xs font-bold w-full justify-center border-t border-gray-100 pt-4">
          ${scholarHtml} ${separatorHtml} ${dblpHtml}
        </div>
      `;
    }

    // Build the card. Notice the data-category and data-name attributes for your vanilla JS filter logic.
    cardsHtml += `
      <div class="bg-white border border-gray-200 rounded-2xl p-6 shadow-sm hover:shadow-xl hover:border-[#C53030] transition-all duration-300 flex flex-col items-center text-center group cursor-pointer person-card" 
           data-category="${person.category}" 
           data-name="${person.name}">
        <div class="w-24 h-24 mb-4 rounded-full overflow-hidden border-4 border-gray-100 group-hover:border-[#C53030] transition-colors duration-300">
          ${imageHtml}
        </div>
        <h3 class="text-lg font-bold text-gray-900 mb-2 group-hover:text-[#C53030] transition-colors">
          ${person.name}
        </h3>
        <p class="text-sm font-medium text-gray-600 mb-4 flex-1">
          ${person.role || ""}
        </p>
        ${linksHtml}
      </div>
    `;
  });

  // Wrap the cards in the grid container
  const finalGridHtml = `<div class="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-6 mb-12" id="people-grid">${cardsHtml}</div>`;

  // Read the template, inject the grid, and write the final output
  const templatePath = path.join(process.cwd(), "people.template.html");
  const templateHtml = fs.readFileSync(templatePath, "utf8");

  // FIXED: Restored the proper placeholder target
  const finalHtml = templateHtml.replace(
    "___PEOPLE_GRID_PLACEHOLDER___",
    finalGridHtml,
  );

  fs.writeFileSync(path.join(process.cwd(), "people.html"), finalHtml);
  console.log(
    `Successfully generated people.html with ${people.length} profiles!`,
  );
}

buildPeoplePage();
