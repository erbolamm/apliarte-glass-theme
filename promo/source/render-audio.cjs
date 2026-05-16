const { chromium } = require('playwright');
const { createServer } = require('http');
const { readFileSync, writeFileSync, unlinkSync, mkdirSync } = require('fs');
const { join } = require('path');
const { spawnSync } = require('child_process');

const PROMO_DIR = join(__dirname, '..');
const VIDEOS_DIR = join(PROMO_DIR, 'videos');
const SOURCE_DIR = join(__dirname);

async function generateAudioForDuration(duration, port) {
  return new Promise(async (resolve, reject) => {
    const server = createServer((req, res) => {
      if (req.url === '/' || req.url.startsWith('/?duration=')) {
        const html = readFileSync(join(SOURCE_DIR, 'generate-audio.html'), 'utf-8');
        res.writeHead(200, { 'Content-Type': 'text/html' });
        res.end(html);
      } else {
        res.writeHead(404);
        res.end();
      }
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
  console.log('🎵 Generando audios...\n');

  const videos = [
    { name: 'promo-vertical', duration: '22' },
    { name: 'promo-horizontal', duration: '30' },
  ];

  for (const video of videos) {
    const port = 8766 + (video.duration === '22' ? 0 : 1);
    const wavPath = await generateAudioForDuration(video.duration, port);
    const inputPath = join(VIDEOS_DIR, `${video.name}.mp4`);
    const outputPath = join(VIDEOS_DIR, `${video.name}-with-music.mp4`);

    console.log(`  🎬 Mezclando ${video.name}...`);
    const result = spawnSync('ffmpeg', [
      '-i', inputPath,
      '-i', wavPath,
      '-filter_complex',
        `[1:a]atrim=duration=${video.duration},afade=t=in:d=1,afade=t=out:st=${parseFloat(video.duration) - 2}:d=1[aout]`,
      '-map', '0:v:0',
      '-map', '[aout]',
      '-c:v', 'copy',
      '-c:a', 'aac',
      '-b:a', '192k',
      '-t', video.duration,
      '-y',
      outputPath,
    ], { timeout: 30000 });

    if (result.status === 0) {
      const mb = (readFileSync(outputPath).length / 1024 / 1024).toFixed(1);
      console.log(`  ✅ ${video.name}-with-music.mp4 (${mb}MB)`);
    } else {
      console.error(`  ❌ ${video.name}:`, result.stderr.toString().slice(-300));
    }

    unlinkSync(wavPath);
    console.log('');
  }

  console.log('✅ Todos los videos con música listos en promo/videos/');
}

main().catch(console.error);
