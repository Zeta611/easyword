import { defineConfig } from 'vite'
import legacy from 'vite-plugin-legacy-swc'
import react from '@vitejs/plugin-react-swc'

export default defineConfig({
  build: {
    minify: 'terser',
    cssMinify: 'lightningcss',
    terserOptions: {
      compress: {
        passes: 5
      }
    }
  },
  plugins: [
    react(),
    legacy({
      modernPolyfills: ['es.array.to-sorted']
    })
  ]
})
