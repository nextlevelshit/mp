<template>
	<header class="text-gray-900">
		<div class="lg:container mx-auto p-4 py-6 lg:py-8">
			<div class="flex flex-col lg:flex-row gap-12 py-6">
				<router-link to="/" class="lg:w-1/4" @click="trackEvent(`header-logo-clicked`)">
					<h1 class="tracking-wide text-3xl font-bebas leading-none">
						MUELLERPRINTS.<br/>Paperwork
					</h1>
				</router-link>
				<div v-if="$route.name" role="navigation" class="grow lg:w-3/4">
					<nav class="flex justify-end" v-if="isCheckoutRoute" aria-label="Navigation">
						<router-link class="hover:text-gray-400" to="/cart" @click="trackEvent(`header-back-to-cart-clicked`)">
							Zurück zum Warenkorb
						</router-link>
					</nav>
					<nav class="flex flex-col lg:flex-row justify-between gap-4 lg:gap-28 lg:h-full" v-else aria-label="Navigation">
						<div class="flex flex-col lg:flex-row gap-4 lg:gap-8">
							<HeaderNavLink label="Notizbücher und Notizhefte" path="/products" @click="trackEvent(`header-products-clicked`)" />
							<HeaderNavLink label="Herstellung" path="/production" @click="trackEvent(`header-production-clicked`)" />
						</div>
						<HeaderNavLink :label="`Warenkorb (${productsCount})`" path="/cart" @click="trackEvent(`header-cart-clicked`)"/>
					</nav>
				</div>
			</div>
		</div>
	</header>
</template>

<script lang="ts">
import {cart} from "@/stores/cart";
import HeaderNavLink from "@/components/HeaderNavLink.vue";
import {trackEvent} from "@/util/trackEvent";

export default {
	methods: {trackEvent},
	components: {HeaderNavLink},
	computed: {
		productsCount() {
			return cart.productsCount;
		},
		isCheckoutRoute() {
			return String(this.$route.name).startsWith("checkout-");
		}
	},
}
</script>
