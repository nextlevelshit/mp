<template>
	<main class="pt-4 container mx-auto">
		<div class="flex gap-12 relative">
			<div class="w-1/4">
				<div class="sticky top-4">
					<h1 class="text-2xl pb-4">Notizbücher und Notizhefte</h1>
					<p>Alle Notizhefte sind von uns selbst gestaltet, gedruckt und in Handarbeit gebunden. Das
						eingesetzte, matte Recyclingpapier mit feiner Textur sorgt für angenehmes Schreiben und
						Skizzieren. Um den Inhalt liegt ein Matelbogen aus rot durchgefärbtem Papier, was einen
						dezenten, farbigen Kontrast zu dem ansonsten absichtlich, schwarz-weiß gehaltenen Design
						setzt.</p>
				</div>
			</div>

			<div class="w-3/4 grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-8">
				<ProductCard v-for="(item, i) in list" :key="i" :product="item" :cartUuid="cartUuid"/>
			</div>
		</div>

		<CodeBlock class="mt-8">{{ JSON.stringify(list, null, 2) }}</CodeBlock>
	</main>
</template>
<script>
import debug from "debug";
import {shopApi} from "@/services/ShopApi";
import {localStorageLabelCartUuid} from "@/config/constants";
import CodeBlock from "@/components/CodeBlock.vue";
import ProductCard from "@/components/ProductCard.vue";
import Header from "@/components/Header.vue";

const logger = debug("app:i:product-list-view");
const verbose = debug("app:v:product-list-view");

export default {
	components: {Header, ProductCard, CodeBlock},
	data() {
		return {
			list: null,
			cartUuid: null,
			cart: null
		}
	},
	async mounted() {
		this.list = await shopApi.getProducts();

		try {
			let cartUuid = localStorage.getItem(localStorageLabelCartUuid);

			const result = await shopApi.getOrCreateOrder(cartUuid);
			// TODO: Fix error handling
			this.cartUuid = result.uuid;
			this.cart = result;
			localStorage.setItem(localStorageLabelCartUuid, this.cartUuid);
		} catch (error) {
			logger("Error fetching or creating cart:", error);
			localStorage.removeItem(localStorageLabelCartUuid);
		}
	},
	methods: {}
}
</script>
