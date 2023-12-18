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
        port: 9999,
        // proxy: {
        //     '/api': {
        //         target: `http://mp-shop-api:8888/`,
        //         // changeOrigin: true,
        //         rewrite: (path) => path.replace(/^\/api/, ''),
        //     },
        //     '/uploads': {
        //         target: `http://mp-depot:5555/`,
        //         // changeOrigin: true,
        //         // rewrite: (path) => path.replace(/^\/api/, ''),
        //     },
        // },
    }
})
