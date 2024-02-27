import { createRouter, createWebHistory } from "vue-router";

const router = createRouter({
	history: createWebHistory(import.meta.env.VITE_BASE_URL),
	routes: [
		{
			path: "/",
			name: "root",
			redirect: "/products"
		},
		{
			path: "/terms",
			name: "legal-terms",
			component: () => import("./views/legal/TermsView.vue")
		},
		{
			path: "/imprint",
			name: "legal-imprint",
			component: () => import("./views/legal/ImprintView.vue")
		},
		{
			path: "/privacy",
			name: "legal-privacy",
			component: () => import("./views/legal/PrivacyView.vue")
		},
		{
			path: "/payment",
			name: "legal-payment",
			component: () => import("./views/legal/PaymentMethodsView.vue")
		},
		{
			path: "/products",
			name: "product-list",
			component: () => import("./views/ProductListView.vue")
		},
		{
			path: "/details/:id",
			props: true,
			name: "product-details",
			component: () => import("./views/ProductDetailsView.vue")
		},
		{
			path: "/cart",
			name: "cart",
			component: () => import("./views/CartView.vue")
		},
		{
			path: "/checkout/1",
			alias: ["/checkout"],
			name: "checkout-email",
			component: () => import("./views/checkout/CheckoutEmailView.vue")
		},
		{
			path: "/checkout/2",
			name: "checkout-address",
			component: () => import("./views/checkout/CheckoutAddressView.vue")
		},
		{
			path: "/checkout/3",
			name: "checkout-payment",
			component: () => import("./views/checkout/CheckoutPaymentView.vue")
		},
		{
			path: "/checkout/result/:uuid",
			name: "checkout-result",
			props: true,
			component: () => import("./views/checkout/CheckoutResultView.vue")
		},
		{
			path: "/health",
			name: "health",
			redirect: { name: "root" },
		},
	]
});

export default router;
