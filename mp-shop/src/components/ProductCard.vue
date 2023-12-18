<template>
	<div class="border p-4">
		<img :src="product.image.url" :alt="product.name" class="w-full h-40 object-cover mb-4">
		<div class="flex flex-col justify-between">
			<div>
				<a :href="`/details/${product.id}`" class="text-blue-600 font-bold">{{ product.name }}</a>
				<p class="text-gray-600">{{ product.totalProductPrice.toFixed(2) }} €</p>
			</div>
			<button
				@click="addToCart(product.id)"
				:disabled="isAddingToCart"
				:class="{ 'opacity-50': isAddingToCart }"
				class="mt-4 bg-blue-500 text-white px-4 py-2 rounded-full hover:bg-blue-600 cursor-pointer"
			>
				<span v-if="isAddingToCart">Adding...</span>
				<span v-else>Add to Cart</span>
			</button>
		</div>
	</div>
</template>

<script>
import {shopApi} from "@/services/ShopApi";
import debug from "debug";
import {cart} from "@/stores/cart";

const logger = debug("app:i:product-card");
const verbose = debug("app:v:product-card");

export default {
	data() {
		return {
			isAddingToCart: false
		}
	},
	props: ["product", "cartUuid"],
	methods: {
		async addToCart(productId) {
			verbose(`Adding product with ID ${productId} to cart`);

			try {
				this.isAddingToCart = true;
				await shopApi.addProductToCart(this.cartUuid, productId);
			} catch (error) {
				logger(`Could not add product ${productId} to cart:`, error);
			} finally {
				this.isAddingToCart = false;
        cart.fetch();
			}
		}
	},
};
</script>
