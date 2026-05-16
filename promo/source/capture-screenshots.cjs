const { chromium } = require('playwright');
const { createServer } = require('http');
const { readFileSync, readdirSync, mkdirSync } = require('fs');
const { join } = require('path');

const PROMO_DIR = join(__dirname, '..');
const SCREENSHOTS_DIR = join(PROMO_DIR, 'screenshots');

for (const dir of ['ios', 'android', 'browser']) {
  mkdirSync(join(SCREENSHOTS_DIR, dir), { recursive: true });
}

const html = readFileSync(join(__dirname, 'screenshots.html'), 'utf-8');

async function main() {
  const server = createServer((req, res) => {
    if (req.url === '/' || req.url === '/index.html') {
      res.writeHead(200, { 'Content-Type': 'text/html; charset=utf-8' });
      res.end(html);
    } else {
      res.writeHead(404);
      res.end();
    }
  });

  await new Promise(resolve => server.listen(8765, resolve));
  console.log('🌐 Server on http://localhost:8765');

  const browser = await chromium.launch({ headless: true });
  const context = await browser.newContext({
    viewport: { width: 1440, height: 900 },
    deviceScaleFactor: 2,
  });

  const page = await context.newPage();

  try {
    await page.goto('http://localhost:8765', { waitUntil: 'networkidle' });
    await page.waitForTimeout(800);

    const basePath = join(SCREENSHOTS_DIR, 'browser');

    // 1. Full page
    console.log('📸 Full page...');
    await page.screenshot({ path: join(basePath, 'full-overview.png'), fullPage: true });

    // 2. Hero
    console.log('📸 Hero...');
    const hero = page.locator('.hero');
    if (await hero.count() > 0) await hero.screenshot({ path: join(basePath, 'hero.png') });

    // 3. Light components grid
    console.log('📸 Components light...');
    const grid = page.locator('.grid').first();
    if (await grid.count() > 0) await grid.screenshot({ path: join(basePath, 'components-light.png') });

    // 4. Drawer
    console.log('📸 Drawer...');
    const drawerContainer = page.locator('div[style*="justify-content:center"]').first();
    if (await drawerContainer.count() > 0) await drawerContainer.screenshot({ path: join(basePath, 'drawer.png') });

    // 5. Dark theme
    console.log('📸 Dark theme...');
    const darkGlass = page.locator('.dark-glass');
    if (await darkGlass.count() > 0) await darkGlass.screenshot({ path: join(basePath, 'dark-theme.png') });

    // 6. Phone mockup
    console.log('📸 Phone mockup...');
    const phoneFrame = page.locator('[style*="border-radius:32px"]').first();
    if (await phoneFrame.count() > 0) await phoneFrame.screenshot({ path: join(basePath, 'app-mockup.png') });

    // 7. Warm preset
    console.log('📸 Warm preset...');
    const warmGrid = page.locator('h2.section-title:has-text("Warm Preset") + div.grid');
    if (await warmGrid.count() > 0) await warmGrid.screenshot({ path: join(basePath, 'warm-preset.png') });

    // 8. Individual component cards
    console.log('📸 Individual components...');
    const cards = page.locator('.screenshot-card');
    const count = await cards.count();
    for (let i = 0; i < count; i++) {
      const card = cards.nth(i);
      const label = await card.locator('.label').textContent();
      const safeName = label.trim().toLowerCase().replace(/[^a-z0-9]+/g, '-').replace(/-+$/, '');
      await card.screenshot({ path: join(basePath, `component-${i}-${safeName}.png`) });
      console.log(`  → ${safeName}`);
    }

    console.log('\n✅ Todas las screenshots capturadas!');
    const files = readdirSync(basePath).filter(f => f.endsWith('.png'));
    console.log(`   📁 ${basePath}/ (${files.length} PNGs)`);
    for (const f of files) {
      const bytes = readFileSync(join(basePath, f)).length;
      console.log(`   ${(bytes / 1024).toFixed(0)}KB  ${f}`);
    }

  } catch (err) {
    console.error('❌ Error:', err.message);
  } finally {
    await browser.close();
    server.close();
  }
}

main().catch(console.error);
