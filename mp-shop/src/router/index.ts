import { createRouter, createWebHistory } from "vue-router";

const router = createRouter({
	history: createWebHistory(import.meta.env.BASE_URL),
	routes: [
		{
			path: "/",
			name: "root",
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
			path: "/checkout/1",
			alias: ["/checkout"],
			name: "checkout-email",
			component: () => import("../views/checkout/CheckoutEmailView.vue")
		},
		{
			path: "/checkout/2",
			name: "checkout-address",
			component: () => import("../views/checkout/CheckoutAddressView.vue")
		},
		{
			path: "/checkout/3",
			name: "checkout-payment",
			component: () => import("../views/checkout/CheckoutPaymentView.vue")
		},
		{
			path: "/checkout/result/:uuid",
			name: "checkout-result",
			props: true,
			component: () => import("../views/checkout/CheckoutResultView.vue")
		},
		{
			path: "/health",
			name: "health",
			redirect: { name: "root" },
		},
	]
});

export default router;
