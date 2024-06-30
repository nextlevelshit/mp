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
        port: 9999,
    },
	// // TODO: Should not be necessary
	// define: {
	// 	VITE_BASE_URL: JSON.stringify(process.env.VITE_BASE_URL),
	// 	VITE_PAYMENT_ENVIRONMENT: JSON.stringify(process.env.VITE_PAYMENT_ENVIRONMENT),
	// 	VITE_UMAMI_WEBSITE_ID: JSON.stringify(process.env.VITE_UMAMI_WEBSITE_ID),
	// 	VITE_BOOKLET_COVER_ID: process.env.VITE_BOOKLET_COVER_ID,
	// 	VITE_SOFT_COVER_ID: process.env.VITE_SOFT_COVER_ID,
	// 	VITE_HARD_COVER_ID: process.env.VITE_HARD_COVER_ID,
	// }
})
