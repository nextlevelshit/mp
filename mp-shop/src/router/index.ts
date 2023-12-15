import { createRouter, createWebHistory } from "vue-router";

const router = createRouter({
	history: createWebHistory(import.meta.env.BASE_URL),
	routes: [
		{
			path: "/",
			redirect: "/products"
		},
		{
			path: "/products",
			name: "product-list",
			component: () => import("../views/ProductListView.vue")
		},
		{
			path: "/details/:id",
			props: true,
			name: "product-details",
			component: () => import("../views/ProductDetailsView.vue")
		},
		{
			path: "/cart",
			name: "cart",
			component: () => import("../views/CartView.vue")
		},
		{
			path: "/checkout",
			name: "checkout",
			component: () => import("../views/CheckoutView.vue")
		},
		{
			path: "/checkout/result/:state",
			name: "checkout-result",
			props: true,
			component: () => import("../views/CheckoutResultView.vue")
		}
	]
});

export default router;
