import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);
const rootDir = path.join(__dirname, '..');

const replaceExtensions = (content) => {
  return content.replace(/assets\/([^"'\\]+?)\.(png|jpg|jpeg)/gi, 'assets/$1.webp');
};

const addLazyLoading = (content) => {
  // Add loading="lazy" decoding="async" if not present
  return content.replace(/<img\s+(?!.*?loading=)/gi, '<img loading="lazy" decoding="async" ');
};

async function processDirectory(directory) {
  const files = fs.readdirSync(directory);

  for (const file of files) {
    if (file === 'node_modules' || file === '.git') continue;

    const fullPath = path.join(directory, file);
    const stat = fs.statSync(fullPath);

    if (stat.isDirectory()) {
      await processDirectory(fullPath);
    } else {
      const ext = path.extname(file).toLowerCase();
      if (['.html', '.js'].includes(ext)) {
        try {
          let content = fs.readFileSync(fullPath, 'utf8');
          let newContent = content;

          // Replace extensions
          newContent = replaceExtensions(newContent);

          // Add lazy loading for HTML files only (JS generates some html strings, we can handle them manually or automatically)
          if (ext === '.html') {
             newContent = addLazyLoading(newContent);
          }

          if (content !== newContent) {
            fs.writeFileSync(fullPath, newContent, 'utf8');
            console.log(`Updated: ${fullPath}`);
          }
        } catch (error) {
          console.error(`Error processing ${fullPath}:`, error);
        }
      }
    }
  }
}

async function main() {
  console.log('Updating HTML and JS files...');
  await processDirectory(rootDir);
  console.log('Update complete.');
}

main().catch(console.error);
