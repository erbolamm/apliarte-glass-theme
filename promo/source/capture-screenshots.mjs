import { chromium } from 'playwright';
import { createServer } from 'http';
import { readFileSync } from 'fs';
import { join, dirname } from 'path';
import { fileURLToPath } from 'url';
import { mkdirSync } from 'fs';

const __dirname = dirname(fileURLToPath(import.meta.url));
const PROMO_DIR = join(__dirname, '..');
const SCREENSHOTS_DIR = join(PROMO_DIR, 'screenshots');

// Ensure dirs exist
for (const dir of ['ios', 'android', 'browser']) {
  mkdirSync(join(SCREENSHOTS_DIR, dir), { recursive: true });
}

const html = readFileSync(join(__dirname, 'screenshots.html'), 'utf-8');

// Simple HTTP server to serve the HTML
const server = createServer((req, res) => {
  if (req.url === '/') {
    res.writeHead(200, { 'Content-Type': 'text/html; charset=utf-8' });
    res.end(html);
  } else {
    res.writeHead(404);
    res.end();
  }
});

await new Promise(resolve => server.listen(8765, resolve));
console.log('Server on http://localhost:8765');

const browser = await chromium.launch({ headless: true });
const context = await browser.newContext({
  viewport: { width: 1440, height: 900 },
  deviceScaleFactor: 2,
});

const page = await context.newPage();

try {
  await page.goto('http://localhost:8765', { waitUntil: 'networkidle' });
  await page.waitForTimeout(500);

  const basePath = join(SCREENSHOTS_DIR, 'browser');

  // 1. Full page
  console.log('📸 Full page...');
  await page.screenshot({
    path: join(basePath, 'full-overview.png'),
    fullPage: true,
  });

  // 2. Hero section
  console.log('📸 Hero...');
  const hero = page.locator('.hero');
  await hero.screenshot({ path: join(basePath, 'hero.png') });

  // 3. Components grid (first group)
  console.log('📸 Components light...');
  const lightGrid = page.locator('.grid').first();
  await lightGrid.screenshot({ path: join(basePath, 'components-light.png') });

  // 4. Drawer
  console.log('📸 Drawer...');
  const drawer = page.locator('.drawer-demo');
  await drawer.screenshot({ path: join(basePath, 'drawer.png') });

  // 5. Dark theme section
  console.log('📸 Dark theme...');
  const darkSection = page.locator('.dark-glass');
  await darkSection.screenshot({ path: join(basePath, 'dark-theme.png') });

  // 6. Full app mockup
  console.log('📸 App mockup...');
  const appMockup = page.locator('div').filter({ has: page.locator('.nav-indicator') }).last();
  // Try to find the phone mockup more precisely
  const phoneFrame = page.locator('[style*="border-radius:32px"]');
  if (await phoneFrame.count() > 0) {
    await phoneFrame.screenshot({ path: join(basePath, 'app-mockup.png') });
  } else {
    console.log('⚠️ Phone frame not found, taking full page for app mockup');
  }

  // 7. Warm preset
  console.log('📸 Warm preset...');
  const warmSection = page.locator('.section-title').filter({ hasText: 'Warm Preset' }).locator('..');
  // Find warm grid
  const warmGrid = page.locator('h2.section-title').filter({ hasText: 'Warm Preset' }).locator('+ .grid');
  if (await warmGrid.count() > 0) {
    await warmGrid.screenshot({ path: join(basePath, 'warm-preset.png') });
  }

  // 8. Individual component close-ups
  console.log('📸 Individual cards...');
  const cards = page.locator('.screenshot-card');
  const count = await cards.count();
  for (let i = 0; i < count; i++) {
    const card = cards.nth(i);
    const label = await card.locator('.label').textContent();
    const safeName = label.trim().toLowerCase().replace(/[^a-z0-9]+/g, '-').replace(/-+$/, '');
    await card.screenshot({ path: join(basePath, `component-${i}-${safeName}.png`) });
    console.log(`  → ${safeName}`);
  }

  console.log('\n✅ Todas las screenshots capturadas en promo/screenshots/browser/');

} catch (err) {
  console.error('❌ Error:', err.message);
} finally {
  await browser.close();
  server.close();
}
