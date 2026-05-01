import { createClient } from "@supabase/supabase-js";
import fs from "fs";
import path from "path";

const supabase = createClient(
  process.env.SUPABASE_URL,
  process.env.SUPABASE_ANON_KEY,
);

async function buildPeoplePage() {
  console.log("Fetching people from Supabase...");
  // 1. Fetch all people without strict database sorting, we will sort in memory
  const { data: people, error } = await supabase.from("people").select("*");

  if (error) {
    console.error("Error fetching people:", error);
    return;
  }

  // 2. The Intelligent Multi-Tier Sorting Algorithm
  const categoryWeights = {
    faculty: 1,
    staff: 2,
    collaborator: 3,
    student: 4,
    alumni: 5,
  };

  people.sort((a, b) => {
    // Tier 1: Member Key (Lowest number wins. If empty, treat as 9999 so they go lower)
    const keyA = a.member_key ? parseInt(a.member_key) || 9999 : 9999;
    const keyB = b.member_key ? parseInt(b.member_key) || 9999 : 9999;
    if (keyA !== keyB) return keyA - keyB;

    // Tier 2: Category Hierarchy (Faculty first, Alumni last)
    const catA = categoryWeights[a.category] || 99;
    const catB = categoryWeights[b.category] || 99;
    if (catA !== catB) return catA - catB;

    // Tier 3: Photo Presence (People with photos go above people without photos)
    const photoA = a.photo_url ? 0 : 1;
    const photoB = b.photo_url ? 0 : 1;
    if (photoA !== photoB) return photoA - photoB;

    // Tier 4: Alphabetical tie-breaker
    const nameA = a.name ? a.name.toLowerCase() : "";
    const nameB = b.name ? b.name.toLowerCase() : "";
    return nameA.localeCompare(nameB);
  });

  let cardsHtml = "";
  people.forEach((person) => {
    let imageHtml = "";

    // --- LOCAL ASSET ROUTING WITH FALLBACK ---
    if (person.photo_url) {
      const filename = person.photo_url.split("/").pop();
      const localImagePath = `assets/people/${filename}`;
      imageHtml = `<img src="${localImagePath}" onerror="this.onerror=null; this.src='${person.photo_url}';" alt="${person.name}" class="w-full h-full object-cover ${person.name.includes("Rizk") ? "object-top" : ""}"/>`;
    } else {
      imageHtml = `<div class="w-full h-full bg-gray-50 flex items-center justify-center group-hover:bg-red-50 transition-colors duration-300"><i class="bx bx-user text-4xl text-gray-300 group-hover:text-[#C53030]"></i></div>`;
    }

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
      linksHtml = `<div class="mt-auto flex gap-3 text-xs font-bold w-full justify-center border-t border-gray-100 pt-4">${scholarHtml} ${separatorHtml} ${dblpHtml}</div>`;
    }

    cardsHtml += `
      <div class="bg-white border border-gray-200 rounded-2xl p-6 shadow-sm hover:shadow-xl hover:border-[#C53030] transition-all duration-300 flex flex-col items-center text-center group cursor-pointer person-card" data-category="${person.category}" data-name="${person.name}">
        <div class="w-24 h-24 mb-4 rounded-full overflow-hidden border-4 border-gray-100 group-hover:border-[#C53030] transition-colors duration-300">${imageHtml}</div>
        <h3 class="text-lg font-bold text-gray-900 mb-2 group-hover:text-[#C53030] transition-colors">${person.name}</h3>
        <p class="text-sm font-medium text-gray-600 mb-4 flex-1">${person.role || ""}</p>
        ${linksHtml}
      </div>`;
  });

  // Inject the count display at the bottom of the grid
  const countHtml = `
    <div class="col-span-1 sm:col-span-2 md:col-span-3 lg:col-span-4 mt-8 border-t border-gray-200 pt-8 flex flex-col items-center">
      <div class="text-sm text-gray-500 font-bold tracking-wide">Showing ${people.length} people</div>
    </div>
  `;

  const finalGridHtml = `<div class="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-6 mb-12" id="people-grid">${cardsHtml}${countHtml}</div>`;

  const templatePath = path.join(process.cwd(), "people.template.html");
  if (fs.existsSync(templatePath)) {
    const templateHtml = fs.readFileSync(templatePath, "utf8");
    const finalHtml = templateHtml.replace(
      "___PEOPLE_GRID_PLACEHOLDER___",
      finalGridHtml,
    );
    fs.writeFileSync(path.join(process.cwd(), "people.html"), finalHtml);
    console.log(
      `Successfully generated people.html with ${people.length} profiles!`,
    );
  }
}

async function buildPublicationsPage() {
  console.log("Fetching publications & books from Supabase...");

  // Fetch Books
  const { data: books, error: booksError } = await supabase
    .from("books")
    .select("*")
    .order("pub_year", { ascending: false });
  if (booksError) {
    console.error("Error fetching books:", booksError);
    return;
  }

  let booksHtml = "";
  books.forEach((book) => {
    // Local image routing for books
    let imageHtml = "";
    if (book.image_url) {
      const filename = book.image_url.split("/").pop();
      const localImagePath = `assets/books/${filename}`;
      // Added min-width so broken images don't collapse to 0 pixels
      imageHtml = `<img src="${localImagePath}" onerror="this.onerror=null; this.src='${book.image_url}';" alt="${book.title}" class="h-48 md:h-56 lg:h-64 w-auto rounded-lg object-contain bg-white/50 p-2 border border-gray-200" style="min-width: 130px;"/>`;
    } else {
      // Fallback placeholder for books with no image URL
      imageHtml = `<div class="h-48 md:h-56 lg:h-64 w-[130px] md:w-[150px] rounded-lg bg-gray-50 border border-gray-200 flex flex-col items-center justify-center p-3 text-center shadow-sm"><i class='bx bx-book-content text-4xl text-gray-300 mb-2'></i><span class="text-xs font-bold text-gray-500 line-clamp-3">${book.title}</span></div>`;
    }

    booksHtml += `
      <a href="${book.amazon_url || book.publisher_url || "#"}" target="_blank" class="shrink-0 snap-start transition-transform duration-300 hover:-translate-y-2 hover:drop-shadow-xl flex">
        ${imageHtml}
      </a>`;
  });

  // Fetch Publications
  const { data: publications, error: pubError } = await supabase
    .from("publications")
    .select("*")
    .order("pub_year", { ascending: false });
  if (pubError) {
    console.error("Error fetching publications:", pubError);
    return;
  }

  const samples = publications.filter((p) => p.is_sample === true);
  const papers = publications.filter((p) => p.is_sample !== true);

  // Group Samples by Year
  const samplesByYear = {};
  samples.forEach((pub) => {
    const year = pub.pub_year || "Unknown";
    if (!samplesByYear[year]) samplesByYear[year] = [];
    samplesByYear[year].push(pub);
  });

  // Generate Samples HTML (Pills + Lists)
  const years = Object.keys(samplesByYear).sort().reverse();

  let yearPillsHtml = `<div class="flex flex-wrap gap-2 mb-8 bg-gray-50 p-3 rounded-xl border border-gray-200" id="year-filter-container">
    <button class="year-btn active px-4 py-1.5 rounded-lg text-sm font-bold transition-all duration-200 bg-[#C53030] text-white shadow-sm" data-year="All">All</button>`;
  years.forEach((year) => {
    yearPillsHtml += `<button class="year-btn px-4 py-1.5 rounded-lg text-sm font-bold transition-all duration-200 bg-white text-gray-600 hover:bg-gray-100 border border-gray-200" data-year="${year}">${year}</button>`;
  });
  yearPillsHtml += `</div>`;

  let samplesListHtml = `<div id="samples-sections">`;
  years.forEach((year) => {
    samplesListHtml += `
      <div class="year-section mb-10" data-year="${year}">
        <div class="flex items-baseline gap-4 mb-4 border-b border-gray-200 pb-2">
          <h2 class="text-2xl font-bold text-gray-900">${year}</h2>
        </div>
        <ul class="space-y-4">`;

    samplesByYear[year].forEach((pub) => {
      const linkHtml = pub.paper_url
        ? `<a href="${pub.paper_url}" target="_blank" class="ml-2 inline-flex items-center gap-1 px-2 py-0.5 rounded text-xs font-bold transition-colors bg-green-100 text-green-800 hover:bg-green-200 border border-green-200">Link</a>`
        : "";
      samplesListHtml += `
        <li class="group relative pl-4 py-3 rounded-lg hover:bg-white hover:shadow-md transition-all duration-300 border border-transparent hover:border-gray-200">
          <div class="absolute left-0 top-3 bottom-3 w-1 bg-gray-300 group-hover:bg-[#C53030] rounded-r-md transition-colors"></div>
          <div class="text-sm md:text-base text-gray-800 leading-relaxed">
            <span class="text-gray-500 font-medium">${pub.authors}:</span>
            <span class="font-bold text-gray-900">${pub.title}</span>,
            <span class="text-blue-700 font-medium">${pub.venue || ""}</span>
            <span class="text-green-700 font-bold">(${pub.pub_year})</span>
            ${linkHtml}
          </div>
        </li>`;
    });
    samplesListHtml += `</ul></div>`;
  });
  samplesListHtml += `</div>`;
  const finalSamplesHtml = yearPillsHtml + samplesListHtml;

  // Generate Research Papers HTML (Grid)
  let papersHtml = "";
  papers.forEach((pub) => {
    const linkHtml = pub.paper_url
      ? `<a href="${pub.paper_url}" target="_blank" class="mt-3 text-xs font-bold text-blue-600 hover:text-blue-800 transition-colors flex items-center gap-1"><i class='bx bx-link-external'></i> View Paper</a>`
      : "";
    papersHtml += `
      <div class="paper-card group bg-white border border-gray-200 rounded-xl overflow-hidden hover:border-[#C53030] hover:shadow-lg transition-all duration-300 flex flex-col" data-title="${(pub.title || "").toLowerCase()}" data-authors="${(pub.authors || "").toLowerCase()}" data-keywords="${(pub.description || "").toLowerCase()}">
        <div class="p-5 flex flex-col flex-grow">
          <div class="flex justify-between items-start mb-3">
            <h3 class="text-sm sm:text-base font-bold text-gray-900 leading-snug pr-3 group-hover:text-[#C53030] transition-colors line-clamp-2">${pub.title}</h3>
          </div>
          <p class="text-xs text-gray-600 mb-2 font-medium flex-grow">${pub.authors || ""}</p>
          <div class="flex items-center gap-2 text-xs text-gray-500 mt-auto pt-3 border-t border-gray-50">
            <span class="font-bold text-gray-900">${pub.pub_year || ""}</span><span>·</span><span class="line-clamp-1 font-medium">${pub.venue || ""}</span>
          </div>
          ${linkHtml}
        </div>
      </div>`;
  });

  // Inject into Template
  const templatePath = path.join(process.cwd(), "publications.template.html");
  if (fs.existsSync(templatePath)) {
    let templateHtml = fs.readFileSync(templatePath, "utf8");

    templateHtml = templateHtml.replace(
      "___BOOKS_CAROUSEL_PLACEHOLDER___",
      booksHtml,
    );
    templateHtml = templateHtml.replace(
      "___FEW_SAMPLES_PLACEHOLDER___",
      finalSamplesHtml,
    );
    templateHtml = templateHtml.replace(
      "___RESEARCH_PAPERS_PLACEHOLDER___",
      papersHtml,
    );
    templateHtml = templateHtml.replace(
      "___SAMPLES_COUNT_PLACEHOLDER___",
      samples.length,
    );
    templateHtml = templateHtml.replace(
      "___PAPERS_COUNT_PLACEHOLDER___",
      papers.length,
    );

    fs.writeFileSync(
      path.join(process.cwd(), "publications.html"),
      templateHtml,
    );
    console.log(
      `Successfully generated publications.html with ${samples.length} samples, ${papers.length} papers, and ${books.length} books!`,
    );
  }
}

// Run both builds
async function runAll() {
  await buildPeoplePage();
  await buildPublicationsPage();
}

runAll();
