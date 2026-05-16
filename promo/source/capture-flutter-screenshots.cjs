const { chromium } = require('playwright');
const { mkdirSync, readdirSync, statSync } = require('fs');
const { join } = require('path');

const PROMO_DIR = join(__dirname, '..');
const SCREENSHOTS_DIR = join(PROMO_DIR, 'screenshots');
const URL = 'https://erbolamm.github.io/apliarte-glass-theme/';

async function main() {
  for (const dir of ['browser', 'ios', 'android']) {
    mkdirSync(join(SCREENSHOTS_DIR, dir), { recursive: true });
  }

  const browser = await chromium.launch({ headless: true });

  try {
    // ── Desktop full page ──
    console.log('📱 Desktop 1440x900...');
    const desktop = await (await browser.newContext({
      viewport: { width: 1440, height: 900 }, deviceScaleFactor: 2
    })).newPage();
    await desktop.goto(URL, { waitUntil: 'networkidle', timeout: 20000 });
    await desktop.waitForTimeout(4000);
    await desktop.screenshot({ path: join(SCREENSHOTS_DIR, 'browser', 'desktop-full.png'), fullPage: true });
    console.log('  ✅ desktop-full.png');
    await desktop.close();

    // ── Mobile (iPhone 14 Pro) ──
    console.log('📱 Mobile 390x844...');
    const mobile = await (await browser.newContext({
      viewport: { width: 390, height: 844 }, deviceScaleFactor: 3,
      isMobile: true, userAgent: 'Mozilla/5.0 (iPhone; CPU iPhone OS 17_0 like Mac OS X)'
    })).newPage();
    await mobile.goto(URL, { waitUntil: 'networkidle', timeout: 20000 });
    await mobile.waitForTimeout(4000);
    await mobile.screenshot({ path: join(SCREENSHOTS_DIR, 'browser', 'mobile-iphone.png'), fullPage: true });
    console.log('  ✅ mobile-iphone.png');
    await mobile.close();

    // ── Tablet (iPad) ──
    console.log('📱 Tablet 1024x1366...');
    const tablet = await (await browser.newContext({
      viewport: { width: 1024, height: 1366 }, deviceScaleFactor: 2
    })).newPage();
    await tablet.goto(URL, { waitUntil: 'networkidle', timeout: 20000 });
    await tablet.waitForTimeout(4000);
    await tablet.screenshot({ path: join(SCREENSHOTS_DIR, 'browser', 'tablet-ipad.png'), fullPage: true });
    console.log('  ✅ tablet-ipad.png');
    await tablet.close();

    // ── List results ──
    console.log('\n📦 Screenshots en browser/:');
    for (const f of readdirSync(join(SCREENSHOTS_DIR, 'browser')).filter(f => f.endsWith('.png'))) {
      const kb = (statSync(join(SCREENSHOTS_DIR, 'browser', f)).size / 1024).toFixed(0);
      console.log(`   ${kb}KB  ${f}`);
    }
    console.log('\n✅ Listo');

  } catch (err) {
    console.error('❌ Error:', err.message);
  } finally {
    await browser.close();
  }
}
main().catch(console.error);
