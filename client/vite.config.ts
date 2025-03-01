import { VitePWA } from 'vite-plugin-pwa';
import { defineConfig } from 'vite';
import tailwindcss from '@tailwindcss/vite';
import vue from '@vitejs/plugin-vue';

export default defineConfig({
  server: {
    host: true
  },
  plugins: [vue(), tailwindcss(), VitePWA({
    registerType: 'autoUpdate',
    injectRegister: false, 
    strategies: 'injectManifest',
    srcDir: 'src',
    filename: 'service-worker.js',
    injectManifest: {
      swSrc: 'src/service-worker.js',
      swDest: 'dist/service-worker.js',
    },
    manifest: {
      name: 'Linguago',
      short_name: 'Linguago',
      description: 'Une application linguistique puissante',
      theme_color: '#ffffff',
      background_color: '#ffffff',
      display: 'standalone',
      scope: '/',
      start_url: '/',
      icons: [
        {
          src: '/icons/192x192.png',
          sizes: '192x192',
          type: 'image/png'
        },
        {
          src: '/icons/512x512.png',
          sizes: '512x512',
          type: 'image/png'
        }
      ]
    },
    workbox: {
      globPatterns: ['**/*.{js,css,html,svg,png,ico,json,vue,ts}'],
      cleanupOutdatedCaches: true,
      clientsClaim: true,
      skipWaiting: true,
    },
    devOptions: {
      enabled: true,
      navigateFallback: '',
      type: 'module',
    },
  })],
  optimizeDeps: {
    include: ['js-cookie'],
  },
});
