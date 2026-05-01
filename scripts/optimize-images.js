import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';
import sharp from 'sharp';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);
const assetsDir = path.join(__dirname, '..', 'assets');

async function processDirectory(directory) {
  const files = fs.readdirSync(directory);

  for (const file of files) {
    const fullPath = path.join(directory, file);
    const stat = fs.statSync(fullPath);

    if (stat.isDirectory()) {
      await processDirectory(fullPath);
    } else {
      const ext = path.extname(file).toLowerCase();
      if (['.jpg', '.jpeg', '.png'].includes(ext)) {
        const outputFilename = path.basename(file, path.extname(file)) + '.webp';
        const outputPath = path.join(directory, outputFilename);

        try {
          console.log(`Optimizing: ${fullPath} -> ${outputPath}`);
          
          await sharp(fullPath)
            .webp({ quality: 80 })
            .toFile(outputPath);

          console.log(`Deleting original: ${fullPath}`);
          fs.unlinkSync(fullPath);
        } catch (error) {
          console.error(`Error processing ${fullPath}:`, error);
        }
      }
    }
  }
}

async function main() {
  console.log('Starting image optimization...');
  await processDirectory(assetsDir);
  console.log('Image optimization complete.');
}

main().catch(console.error);
