<template>
	<a :href="`/details/${product.id}`" class="gap-2 flex flex-col group">
		<div :class="[bgColor, shadowColor]" class="p-12 rounded-sm shadow-xl group-active:shadow-none">
			<img :src="product.image.url" :alt="product.name" class="w-full object-cover">
		</div>
		<div class="flex flex-col justify-between">
			<div class="px-2 py-4">
				<p class="text-gray-900">{{ product.pattern.name }}</p>
				<p class="text-gray-600">ab {{ product.totalProductPrice.toFixed(2) }} €</p>
			</div>
			<!--			<button-->
			<!--				@click="addToCart(product.id)"-->
			<!--				:disabled="isAddingToCart"-->
			<!--				:class="{ "opacity-50": isAddingToCart }"-->
			<!--				class="mt-4 bg-blue-500 text-white px-4 py-2 rounded-full hover:bg-blue-600 cursor-pointer"-->
			<!--			>-->
			<!--				<span v-if="isAddingToCart">Adding...</span>-->
			<!--				<span v-else>Add to Cart</span>-->
			<!--			</button>-->
		</div>
	</a>
</template>

<script>
import {shopApi} from "@/services/ShopApi";
import debug from "debug";
import {cart} from "@/stores/cart";
import {randomTailwindColor} from "@/util/randomTailwindColor";

const logger = debug("app:i:product-card");
const verbose = debug("app:v:product-card");

export default {
	data() {
		return {
			isAddingToCart: false
		}
	},
	props: ["product", "cartUuid"],
	computed: {
		bgColor() {
			return randomTailwindColor(this.product.pattern.id);
		},
		shadowColor() {
			return randomTailwindColor(this.product.pattern.id, "shadow", 200, "/60");
		}
	},
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
		},
	},
};
</script>
