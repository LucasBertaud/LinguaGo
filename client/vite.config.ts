import { VitePWA } from 'vite-plugin-pwa';
import { defineConfig } from 'vite'
import tailwindcss from '@tailwindcss/vite'
import vue from '@vitejs/plugin-vue'

// https://vitejs.dev/config/
export default defineConfig({
  server: {
    host: true
  },
  plugins: [vue(), tailwindcss(), VitePWA({
    registerType: 'autoUpdate',
    injectRegister: false, 
    filename: 'service-worker.ts',
    srcDir: 'src',
    strategies: 'injectManifest',
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
      swDest: 'dist/service-worker.js', 
      globPatterns: ['**/*.{js,css,html,svg,png,ico,json}'],
      cleanupOutdatedCaches: true,
      clientsClaim: true,
      skipWaiting: true,
    },

    devOptions: {
      enabled: true,
      navigateFallback: 'index.html',
      type: 'module',
    },
  })],
  optimizeDeps: {
    include: ['js-cookie'],
  },
})