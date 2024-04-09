import { defineConfig } from 'vite'
import legacy from '@vitejs/plugin-legacy'
import react from '@vitejs/plugin-react'

export default defineConfig({
  plugins: [
    react(),
    legacy({
      targets: ['last 2 versions, not dead, > 0.2% in KR, iOS >= 12.5'],
      modernPolyfills: ['es/array']
    })
  ]
})
