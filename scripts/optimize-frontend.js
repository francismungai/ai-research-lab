import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);
const rootDir = path.join(__dirname, '..');

const preloadLogo = '<link rel="preload" as="image" href="assets/icons/logo-BHzomKBk.svg" />\n';
const preloadBg = '<link rel="preload" as="image" href="assets/backgrounds/building-bg.webp" />\n';
const preloadLogoPortal = '<link rel="preload" as="image" href="../assets/icons/logo-BHzomKBk.svg" />\n';
const preloadBgPortal = '<link rel="preload" as="image" href="../assets/backgrounds/building-bg.webp" />\n';

async function processDirectory(directory) {
  const files = fs.readdirSync(directory);

  for (const file of files) {
    if (file === 'node_modules' || file === '.git') continue;

    const fullPath = path.join(directory, file);
    const stat = fs.statSync(fullPath);

    if (stat.isDirectory()) {
      await processDirectory(fullPath);
    } else {
      if (path.extname(file).toLowerCase() === '.html') {
        try {
          let content = fs.readFileSync(fullPath, 'utf8');
          let newContent = content;

          // Add defer to scripts with src that don't already have defer
          newContent = newContent.replace(/<script\s+(?![^>]*\bdefer\b)([^>]*\bsrc=["'][^"']+["'][^>]*)>/gi, '<script defer $1>');

          // Inject preloads before </head> if they don't exist
          const isPortal = fullPath.includes(path.join(rootDir, 'portal'));
          const logoStr = isPortal ? preloadLogoPortal : preloadLogo;
          const bgStr = isPortal ? preloadBgPortal : preloadBg;

          let injectStr = '';
          if (!newContent.includes('logo-BHzomKBk.svg"')) {
            // wait, if we check logo-BHzomKBk.svg", it might match the actual image tag. 
            // We should check if it's already in the head or just check if rel="preload" is there.
          }
          
          if (!newContent.includes('rel="preload" as="image" href="assets/icons/logo-BHzomKBk.svg"')) {
             if (!isPortal) injectStr += '    ' + logoStr;
          }
          if (!newContent.includes('rel="preload" as="image" href="../assets/icons/logo-BHzomKBk.svg"')) {
             if (isPortal) injectStr += '    ' + logoStr;
          }

          if (!newContent.includes('rel="preload" as="image" href="assets/backgrounds/building-bg.webp"')) {
             if (!isPortal) injectStr += '    ' + bgStr;
          }
          if (!newContent.includes('rel="preload" as="image" href="../assets/backgrounds/building-bg.webp"')) {
             if (isPortal) injectStr += '    ' + bgStr;
          }

          if (injectStr && newContent.includes('</head>')) {
             newContent = newContent.replace('</head>', injectStr + '</head>');
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
  console.log('Applying frontend optimizations...');
  await processDirectory(rootDir);
  console.log('Update complete.');
}

main().catch(console.error);
