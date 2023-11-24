import {fileURLToPath, URL} from 'node:url'

import {defineConfig} from 'vite'
import vue from '@vitejs/plugin-vue'
import vueJsx from '@vitejs/plugin-vue-jsx'
// import {depotPort, inkassoPort} from "@/config/constants";

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
            '/api/mp-inkasso': {
                target: `http://mp-inkasso:1111/`,
                // changeOrigin: true,
                rewrite: (path) => path.replace(/^\/api\/mp-inkasso/, ''),
            },
            '/api/mp-depot/v1': {
                target: `http://mp-depot:5555/api/`,
                // changeOrigin: true,
                rewrite: (path) => path.replace(/^\/api\/mp-depot\/v1/, ''),
            },
        },
    }
})
