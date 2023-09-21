import {createRouter, createWebHistory} from "vue-router";
import HomeView from "../views/HomeView.vue";

const router = createRouter({
	history: createWebHistory(import.meta.env.BASE_URL),
	routes: [
		{
			path: "/",
			name: "home",
			component: HomeView
		},
		{
			path: "/list/:dto",
			name: "list",
			component: () => import("../views/ListView.vue"),
			props: true
		},
		{
			path: "/edit/invoice/:id",
			props: true,
			alias: ["/edit/invoice", "/create/invoice"],
			name: "edit-invoice",
			component: () => import("../views/InvoiceView.vue")
		},
		{
			path: "/edit/product/:id",
			props: true,
			alias: ["/edit/product", "/create/product"],
			name: "edit-product",
			component: () => import("../views/ProductView.vue")
		},
		{
			path: "/edit/order/:id",
			props: true,
			alias: ["/edit/order", "/create/order"],
			name: "edit-order",
			component: () => import("../views/OrderView.vue")
		},
		{
			path: "/edit/customer/:id",
			props: true,
			alias: ["/edit/customer", "/create/customer"],
			name: "edit-customer",
			component: () => import("../views/CustomerView.vue")
		}
	]
});

export default router;
