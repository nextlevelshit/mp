import { createApp } from "vue";
import App from "./App.vue";
import router from "./router";
import { cart } from "@/stores/cart";

import "./assets/main.css";

const app = createApp(App);

app.use(router);

app.mount("#app");

cart.fetch();
