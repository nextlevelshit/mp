import { createRouter, createWebHistory } from "vue-router";

const router = createRouter({
	history: createWebHistory(import.meta.env.BASE_URL),
	routes: [
		{
			path: "/",
			redirect: "/list/orders"
		},
		{
			path: "/list/orders",
			name: "order-list",
			component: () => import("../views/OrderListView.vue"),
			props: true
		},
		{
			path: "/edit/order/:id",
			props: true,
			alias: ["/edit/order", "/create/order"],
			name: "order-edit",
			component: () => import("../views/OrderView.vue")
		}
	]
});

export default router;
