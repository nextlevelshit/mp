<template>
	<header class="text-gray-900">
		<div class="container mx-auto">
			<div class="flex gap-12 py-6">
				<router-link to="/" class="w-1/4">
					<h1 class="tracking-wide text-2xl font-bebas leading-none">
						MUELLERPRINTS.<br/>Paperwork
					</h1>
				</router-link>
				<div v-if="$route.name" role="navigation" class="grow w-3/4">
					<nav class="flex justify-end" v-if="isCheckoutRoute" aria-label="Navigation">
						<router-link class="hover:text-gray-400" to="/cart">
							Zurück zum Warenkorb
						</router-link>
					</nav>
					<nav class="flex justify-between gap-28 h-full" v-else aria-label="Navigation">
						<div class="flex gap-8">
							<HeaderNavLink label="Notizbücher und Notizhefte" path="/products"/>
							<HeaderNavLink label="Herstellung" path="/production"/>
						</div>
						<HeaderNavLink :label="`Warenkorb (${productsCount})`" path="/cart"/>
					</nav>
				</div>
			</div>
		</div>
	</header>
</template>

<script lang="ts">
import {cart} from "@/stores/cart";
import HeaderNavLink from "@/components/HeaderNavLink.vue";

export default {
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
