const { chromium } = require('playwright');
const { createServer } = require('http');
const { readFileSync, writeFileSync, unlinkSync, mkdirSync } = require('fs');
const { join } = require('path');

const PROMO_DIR = join(__dirname, '..');
const VIDEOS_DIR = join(PROMO_DIR, 'videos');
const SOURCE_DIR = join(__dirname);

async function generateAudioForDuration(duration, port) {
  return new Promise(async (resolve, reject) => {
    const server = createServer((req, res) => {
      const html = readFileSync(join(SOURCE_DIR, 'generate-audio.html'), 'utf-8');
      res.writeHead(200, { 'Content-Type': 'text/html' });
      res.end(html);
    });
    await new Promise(r => server.listen(port, r));

    const browser = await chromium.launch({ headless: true });
    const page = await browser.newPage();
    let audioBase64 = null;
    page.on('console', msg => {
      const text = msg.text();
      if (text.startsWith('AUDIO_DATA:')) audioBase64 = text.replace('AUDIO_DATA:', '');
    });

    try {
      await page.goto(`http://localhost:${port}/?duration=${duration}`, { waitUntil: 'load', timeout: 30000 });
      await page.waitForFunction(() => document.title === 'AUDIO_READY', { timeout: 120000 });

      if (!audioBase64) throw new Error(`No audio for ${duration}s`);
      const wavPath = join(VIDEOS_DIR, `generated-audio-${duration}s.wav`);
      writeFileSync(wavPath, Buffer.from(audioBase64, 'base64'));
      const kb = (readFileSync(wavPath).length / 1024).toFixed(0);
      console.log(`  ✅ Audio ${duration}s: ${kb}KB`);
      resolve(wavPath);
    } catch (e) {
      reject(e);
    } finally {
      await browser.close();
      server.close();
    }
  });
}

async function main() {
  mkdirSync(VIDEOS_DIR, { recursive: true });
  console.log('\ud83c\udfb5 Generando audios para: ApliArte-Glass-Theme\n');

  const audios = [
    { name: 'promo-vertical', duration: '22' },
    { name: 'promo-horizontal', duration: '30' },
  ];

  for (const audio of audios) {
    const port = 8766 + (audio.duration === '22' ? 0 : 1);
    await generateAudioForDuration(audio.duration, port);
  }

  console.log('\n\u2705 Audios listos en promo/videos/');
  console.log('\n\ud83c\udfac Para mezclar con video:');
  console.log('ffmpeg -i video.mp4 -i generated-audio-22s.wav -c:v copy -c:a aac -t 22 -y output.mp4');
}

main().catch(console.error);
