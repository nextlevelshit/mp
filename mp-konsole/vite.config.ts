import {fileURLToPath, URL} from 'node:url'

import {defineConfig} from 'vite'
import vue from '@vitejs/plugin-vue'
import vueJsx from '@vitejs/plugin-vue-jsx'

// https://vitejs.dev/config/
export default defineConfig({
    plugins: [
        vue(),
        vueJsx(),
    ],
    resolve: {
        alias: {
            '@': fileURLToPath(new URL('./src', import.meta.url))
        }
    },
    server: {
        port: 3333,
        proxy: {
            '/api/mp-inkasso/v1': {
                target: 'http://localhost:1111/',
                changeOrigin: true,
                rewrite: (path) => path.replace(/^\/api/, ''),
            },
            '/api/mp-depot/v1': {
                target: 'http://localhost:5555/',
                changeOrigin: true,
                rewrite: (path) => path.replace(/^\/api\/mp-depot\/v1/, '/api'),
            },
        },
    }
})
