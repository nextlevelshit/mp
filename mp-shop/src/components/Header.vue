<template>
	<header class="text-gray-900">
		<div class="lg:container mx-auto">
			<div class="flex flex-col lg:flex-row lg:gap-12 relative bg-white">
				<div class="flex lg:w-1/4 justify-between">
					<router-link to="/" class="max-sm:sticky max-sm:top-0 bg-white p-4 py-6 lg:py-8"
								 @click="trackEvent(`header-logo-clicked`)">
						<h1 class="tracking-wide text-3xl font-bebas leading-none">
							MUELLERPRINTS.<br/>Paperwork
						</h1>
					</router-link>

					<button @click="toggleMobileMenu()" class="bg-white p-4 py-6 lg:py-8 lg:hidden">
						<svg class="w-8 h-8" fill="none" stroke="currentColor" viewBox="0 0 24 24"
							 xmlns="http://www.w3.org/2000/svg">
							<path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
								  d="M4 6h16M4 12h16m-7 6h7"></path>
						</svg>
					</button>
				</div>
				<div v-if="$route.name" role="navigation" class="grow lg:w-3/4 p-4 py-6 lg:py-8 hidden lg:block" :class="{'!block': isMobileMenuOpen}">
					<nav class="flex justify-end" v-if="isCheckoutRoute" aria-label="Navigation">
						<HeaderNavLink label="Zurück zum Warenkorb" to="/cart"
									   @click="trackEvent(`header-back-to-cart-clicked`)"/>
					</nav>
					<nav class="flex flex-col lg:flex-row justify-between gap-4 lg:gap-28 lg:h-full" v-else
						 aria-label="Navigation" @click="closeMobileMenu()">
						<div class="flex flex-col lg:flex-row gap-4 lg:gap-8">
							<HeaderNavLink label="Notizhefte" :path="`/notebooks/${bookletCoverId}`"
										   @click="trackEvent(`header-booklets-clicked`)"/>
							<HeaderNavLink label="Notizbücher" :path="`/notebooks/${softCoverId}`"
										   @click="trackEvent(`header-notebooks-clicked`)"/>
							<HeaderNavLink label="Herstellung" path="/production"
										   @click="trackEvent(`header-production-clicked`)"/>
						</div>
						<HeaderNavLink :label="`Warenkorb (${productsCount})`" path="/cart"
									   @click="trackEvent(`header-cart-clicked`)"/>
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
import {bookletCoverId, softCoverId} from "@/config/constants";

export default {
	data() {
		return {
			isMobileMenuOpen: false
		}
	},
	methods: {
		trackEvent,
		toggleMobileMenu() {
			this.isMobileMenuOpen = !this.isMobileMenuOpen;
		},
		closeMobileMenu() {
			this.isMobileMenuOpen = false;
		}
	},
	components: {HeaderNavLink},
	computed: {
		softCoverId() {
			return softCoverId
		},
		bookletCoverId() {
			return bookletCoverId
		},
		productsCount() {
			return cart.productsCount;
		},
		isCheckoutRoute() {
			return String(this.$route.name).startsWith("checkout-");
		}
	},
}
</script>
