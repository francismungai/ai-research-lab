# USD AI Research Lab

The official website for the **University of South Dakota AI Research Lab**, showcasing research publications, team members, books, blog posts, and ongoing initiatives. Built as a static site with dynamic content powered by Supabase.

**Live Site:** Deployed automatically to GitHub Pages on every push to `main`.

---

## Table of Contents

- [Tech Stack](#tech-stack)
- [Project Structure](#project-structure)
- [Prerequisites](#prerequisites)
- [Getting Started](#getting-started)
- [Supabase Setup](#supabase-setup)
- [Environment Variables](#environment-variables)
- [Development](#development)
- [Build Pipeline](#build-pipeline)
- [Deployment](#deployment)
- [Database Schema](#database-schema)
- [Storage Buckets](#storage-buckets)
- [User Roles & Permissions](#user-roles--permissions)

---

## Tech Stack

| Layer          | Technology                                                  |
| -------------- | ----------------------------------------------------------- |
| Frontend       | HTML, Vanilla JS, [Tailwind CSS v4](https://tailwindcss.com/) |
| Backend / BaaS | [Supabase](https://supabase.com/) (Auth, Database, Storage) |
| Build          | Node.js scripts for static page generation                  |
| Deployment     | GitHub Actions → GitHub Pages                               |
| Icons          | [Boxicons](https://boxicons.com/)                           |

---

## Project Structure

```
ai-research-lab/
├── .github/workflows/
│   └── deploy.yml              # CI/CD: builds and deploys to GitHub Pages
├── assets/
│   ├── backgrounds/            # Site background images
│   ├── blog/                   # Blog cover images (downloaded from Supabase)
│   ├── books/                  # Book cover images (downloaded from Supabase)
│   ├── icons/                  # Logo and icon assets
│   ├── partners/               # Partner logos
│   └── people/                 # Team member photos (downloaded from Supabase)
├── components/
│   ├── navbar.html             # Shared navigation bar
│   └── footer.html             # Shared footer
├── css/
│   ├── input.css               # Tailwind source (custom animations)
│   └── output.css              # Compiled Tailwind output (generated, gitignored)
├── js/
│   ├── supabase-config.js      # Supabase client initialization
│   ├── build.js                # Static site generator (people + publications pages)
│   ├── loader.js               # Component loader (navbar, footer injection)
│   ├── navbar.js               # Navigation logic and auth state
│   ├── toast.js                # Toast notification system
│   ├── login.js                # Login page logic
│   ├── signup.js               # Signup page logic (USD email enforcement)
│   ├── portal.js               # Admin portal logic
│   ├── manage-*.js             # CRUD management scripts for each content type
│   ├── blog.js / blog-post.js  # Blog listing and post rendering
│   └── ...                     # Other page-specific scripts
├── portal/                     # Admin portal pages (manage people, books, etc.)
├── scripts/
│   ├── download-assets.js      # Downloads images from Supabase Storage
│   ├── optimize-images.js      # Image optimization with Sharp
│   └── optimize-frontend.js    # Frontend performance optimizer
├── supabase_schema.sql         # Full database schema dump (tables, policies, functions)
├── supabase_data.sql           # Database data dump
├── *.html                      # Public-facing pages
├── *.template.html             # Templates used by build.js for static generation
├── package.json                # Dependencies and scripts
└── .env                        # Local environment variables (gitignored)
```

---

## Prerequisites

- [Node.js](https://nodejs.org/) v18+ (v20 recommended)
- [Python 3](https://www.python.org/) (for the local dev server)
- A [Supabase](https://supabase.com/) account and project

---

## Getting Started

### 1. Clone the repository

```bash
git clone https://github.com/francismungai/ai-research-lab.git
cd ai-research-lab
```

### 2. Install dependencies

```bash
npm install
```

### 3. Set up environment variables

Create a `.env` file in the project root:

```env
SUPABASE_URL=https://<your-project-ref>.supabase.co
SUPABASE_ANON_KEY=<your-anon-key>
```

### 4. Update the Supabase client config

Open `js/supabase-config.js` and replace the URL and anon key with your own:

```js
const SUPABASE_URL = "https://<your-project-ref>.supabase.co";
const SUPABASE_ANON_KEY = "<your-anon-key>";
```

### 5. Start the development server

```bash
npm run dev
```

This runs two processes concurrently:
- **Tailwind CSS** in watch mode (recompiles on changes)
- **Python HTTP server** on `http://localhost:8000`

---

## Supabase Setup

This project includes SQL dump files so you can replicate the full backend on a new Supabase project.

### Restore the Database

1. **Create a new Supabase project** at [supabase.com/dashboard](https://supabase.com/dashboard)

2. **Get your database connection string** from:
   `Project Settings → Database → Connection string → URI`

3. **Restore the schema** (tables, RLS policies, functions, triggers):

   ```bash
   psql "<your-connection-string>" -f supabase_schema.sql
   ```

4. **Restore the data** (all row data):

   ```bash
   psql "<your-connection-string>" -f supabase_data.sql
   ```

> **Note:** If you don't have `psql` installed locally, you can paste the contents of each SQL file into the **SQL Editor** in the Supabase Dashboard and run them there. Run `supabase_schema.sql` first, then `supabase_data.sql`.

### Create Storage Buckets

The following storage buckets are used for image uploads. Create them in your Supabase Dashboard under **Storage**:

| Bucket Name      | Purpose               | Public |
| ---------------- | --------------------- | ------ |
| `book-covers`    | Book cover images      | Yes    |
| `people-photos`  | Team member photos     | Yes    |
| `blog-covers`    | Blog post cover images | Yes    |

For each bucket, enable **public access** so images can be served directly via URL.

### Configure Authentication

1. Go to **Authentication → Providers** and ensure **Email** is enabled.
2. The database enforces USD email domains only (`@usd.edu` and `@coyotes.usd.edu`) via a trigger on `auth.users`. To allow other emails, modify or remove the `enforce_usd_email` function in the SQL Editor.

### Database Triggers (Webhook Automation)

The schema includes triggers on `people`, `books`, and `publications` tables that fire a webhook to a Supabase Edge Function (`people_gh_hook`) on every insert, update, or delete. This edge function triggers a GitHub Actions `repository_dispatch` event to rebuild and redeploy the site automatically.

**To set up this automation on your fork:**
1. Deploy the `people_gh_hook` edge function (or create your own) that dispatches to your GitHub repo.
2. Update the webhook URLs and authorization tokens in the trigger definitions (see `supabase_schema.sql`).
3. Add the required GitHub secrets (see [Environment Variables](#environment-variables)).

> If you don't need automatic rebuilds, you can safely remove these triggers.

---

## Environment Variables

### Local Development (`.env`)

| Variable            | Description                       |
| ------------------- | --------------------------------- |
| `SUPABASE_URL`      | Your Supabase project URL         |
| `SUPABASE_ANON_KEY` | Your Supabase anonymous/public key |

### GitHub Actions Secrets

Set these in your repo under **Settings → Secrets and variables → Actions**:

| Secret                     | Description                        |
| -------------------------- | ---------------------------------- |
| `PUBLIC_SUPABASE_URL`      | Your Supabase project URL          |
| `PUBLIC_SUPABASE_ANON_KEY` | Your Supabase anonymous/public key |

---

## Development

### Available Scripts

| Command           | Description                                                |
| ----------------- | ---------------------------------------------------------- |
| `npm run dev`     | Starts Tailwind (watch mode) + Python HTTP server on :8000 |
| `npm run tailwind`| Tailwind CSS in watch mode only                            |
| `npm run build`   | One-time Tailwind CSS build (minified)                     |
| `npm run preview` | Static file server via `serve` on port 8000                |
| `npm run server`  | Python HTTP server on port 8000                            |

### Running the Build Scripts Manually

To regenerate the static `people.html` and `publications.html` pages from Supabase data:

```bash
# Set env vars first (PowerShell)
$env:SUPABASE_URL="https://<your-project-ref>.supabase.co"
$env:SUPABASE_ANON_KEY="<your-anon-key>"

# Download images from Supabase Storage
node scripts/download-assets.js

# Generate static HTML pages
node js/build.js

# Compile Tailwind CSS
npm run build
```

---

## Build Pipeline

The static site generation works as follows:

```
Supabase DB ──→ build.js ──→ Fetches people, publications, books
                           ──→ Renders HTML from *.template.html files
                           ──→ Outputs people.html, publications.html

Supabase Storage ──→ download-assets.js ──→ Downloads images to assets/

Tailwind CSS ──→ input.css ──→ output.css (compiled + minified)
```

### How Pages Are Built

1. **Template files** (`people.template.html`, `publications.template.html`) contain placeholder tokens like `___PEOPLE_GRID_PLACEHOLDER___`.
2. **`build.js`** fetches data from Supabase, generates HTML cards/lists, and replaces the placeholders.
3. The final HTML files are written to the project root and deployed as-is.

---

## Deployment

Deployment is fully automated via GitHub Actions (`.github/workflows/deploy.yml`).

### Triggers

| Trigger              | Description                                        |
| -------------------- | -------------------------------------------------- |
| Push to `main`       | Standard deployment on code changes                |
| `repository_dispatch`| Webhook from Supabase triggers a rebuild on data changes |

### What the CI Pipeline Does

1. Checks out the code
2. Installs Node.js dependencies (`npm ci`)
3. Restores cached assets (avoids re-downloading unchanged images)
4. Runs `download-assets.js` to fetch new images from Supabase Storage
5. Runs `build.js` to regenerate `people.html` and `publications.html`
6. Compiles and minifies Tailwind CSS
7. Deploys the entire project to GitHub Pages

---

## Database Schema

### Tables

| Table          | Purpose                                     |
| -------------- | ------------------------------------------- |
| `profiles`     | User profiles linked to Supabase Auth users |
| `people`       | Research lab team members and alumni         |
| `publications` | Research papers and sample publications      |
| `books`        | Published books and textbooks               |
| `blog_posts`   | Blog articles with draft/review/publish flow|

### Database Functions

| Function              | Purpose                                                  |
| --------------------- | -------------------------------------------------------- |
| `enforce_usd_email()` | Trigger function to restrict signups to USD email domains |
| `handle_new_user()`   | Automatically creates a profile row when a user signs up |
| `get_my_role()`       | Returns the current user's role for RLS policy checks    |
| `rls_auto_enable()`   | Event trigger that enables RLS on newly created tables   |

---

## Storage Buckets

| Bucket          | Linked Table | Column          | Local Path       |
| --------------- | ------------ | --------------- | ---------------- |
| `book-covers`   | `books`      | `image_url`     | `assets/books/`  |
| `people-photos` | `people`     | `photo_url`     | `assets/people/` |
| `blog-covers`   | `blog_posts` | `cover_image_url`| `assets/blog/`  |

---

## User Roles & Permissions

The app uses a role-based access control system enforced via Supabase Row Level Security (RLS).

| Role          | Permissions                                                            |
| ------------- | ---------------------------------------------------------------------- |
| `user`        | View own profile. Default role on signup.                               |
| `contributor` | Create blog drafts, edit/delete own posts.                              |
| `editor`      | Manage publications, books, and all blog posts.                         |
| `admin`       | Full access: manage people, users, publications, books, and blog posts. |

### Key RLS Policies

- **Public read access** on `people`, `books`, and `publications` (no auth required)
- **Blog posts** are visible publicly only when `status = 'published'`; authors can see their own drafts
- **Profiles** are restricted to own-profile viewing; admins can manage all
- **Write operations** are gated by role using the `get_my_role()` function

---

## License

This project is maintained by the USD AI Research Lab.
