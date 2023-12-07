<template>
	<div>
		<p>Cart with UUID {{ uuid }}</p>
		<pre>{{ cart }}</pre>
	</div>
</template>

<script>
import { localStorageLabelCartUuid } from "@/config/constants";
import { shopApi } from "@/services/ShopApi";

export default {
	data() {
		return {
			uuid: null,
			cart: null,
		};
	},
	async mounted() {
		try {
			let uuid = localStorage.getItem(localStorageLabelCartUuid);

			const result = await shopApi.getOrCreateCart(uuid);
			this.uuid = result.uuid;
			this.cart = result;
			localStorage.setItem(localStorageLabelCartUuid, this.uuid);
		} catch (error) {
			console.error("Error fetching or creating cart:", error);
			localStorage.removeItem(localStorageLabelCartUuid);
		}
	},
};
</script>
