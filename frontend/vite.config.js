import { fileURLToPath, URL } from 'node:url'

import { defineConfig } from 'vite'
import vue from '@vitejs/plugin-vue'
import tailwindcss from "tailwindcss";
// https://vite.dev/config/
export default defineConfig({
  plugins: [
    vue(),
  ],
    css:{
      postcss: {
          plugins: [tailwindcss()],
      },
    },
    server: {
        host: '0.0.0.0',
        port: 5173,
        strictPort: true,
    },
  resolve: {
    alias: {
      '@': fileURLToPath(new URL('./src', import.meta.url))
    }
  }
})
