import { defineConfig } from 'vite'
import legacy from 'vite-plugin-legacy-swc'
import react from '@vitejs/plugin-react-swc'

export default defineConfig({
  build: {
    minify: 'terser',
    cssMinify: 'lightningcss',
    terserOptions: {
      compress: {
        drop_console: true,
        passes: 5,
        keep_fargs: false,
        toplevel: true
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
