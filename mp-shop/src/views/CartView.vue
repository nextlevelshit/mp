<template>
	<main class="pt-4 pt-8 max-w-screen-md mx-auto">
		<h1 class="text-2xl font-bold mb-4 text-center">Im Warenkorb gesamt: {{numberFormatter(cart.total)}} €</h1>

		<div class="grid place-content-center">
			<a href="/checkout" class="flex-grow-0 bg-black text-white py-4 shadow-md hover:shadow-sm rounded-full w-full uppercase font-thin tracking-wide px-10">
				Bezahlen
			</a>
		</div>

		<div v-if="cartProducts">
			<ul class="divide-y divide-gray-300">
				<li v-for="(position, index) in cartProducts" :key="index"
					class="py-6 gap-4 flex items-center justify-between">

					<img :src="position.product.image.url" :alt="position.product.name" class="w-12 object-cover">

					<span class="text-xl font-bold">{{position.product.name}}</span>

					<select @change="changeCountCart(position, parseInt(($event.target as HTMLInputElement).value))"
							class="block appearance-none w-12 bg-white border border-gray-300 hover:border-gray-500 px-4 py-2 rounded shadow leading-tight focus:outline-none focus:border-indigo-500 focus:shadow-outline">
						<option v-for="count in 10" :selected="position.count === count" :value="count">{{count}}</option>
					</select>

					<div class="flex flex-col gap-2 flex-end">
						<span class="text-xl font-bold text-right">{{ numberFormatter(position.product.totalProductPrice * position.count) }} €</span>
						<button @click="removeFromCart(position.product.id, position.count)" class="text-gray-500 hover:text-gray-900 hover:underline">Entfernen</button>
					</div>
				</li>
			</ul>

			<div class="mt-8">
				<div class="flex justify-between mb-2">
					<span class="text-xl">Zwischensumme</span>
					<span class="text-xl">{{ numberFormatter(cart.subtotal) }} €</span>
				</div>
				<div class="flex justify-between mb-2">
					<span class="text-2xl font-bold">Deine Gesamtsumme</span>
					<div class="flex flex-col flex-end">
						<span class="text-2xl font-bold text-right">{{ numberFormatter(cart.total) }} €</span>
						<span class="text-gray-600 text-sm text-right">Enthält MwSt. in Höhe von {{ numberFormatter(cart.VAT) }} € MwSt.</span>
					</div>
				</div>
			</div>
		</div>

		<div v-else>
			<p class="text-gray-600">Dein Warenkorb ist noch leer</p>
		</div>
	</main>
</template>

<script lang="ts">
import {shopApi} from "@/services/ShopApi";
import CodeBlock from "@/components/CodeBlock.vue";
import debug from "debug";
import {cart} from "@/stores/cart";
import Header from "@/components/Header.vue";
import {numberFormatter} from "@/util/numberFormatter";
import type {Product, CartProduct} from "@/types";

const logger = debug("app:i:cart-view");
const verbose = debug("app:v:cart-view");

export default {
	components: {Header, CodeBlock},
	computed: {
		cart() {
			return cart
		},
		uuid() {
			return cart.uuid;
		},
		cartProducts() {
			return cart.products;
		}
	},
	methods: {
		numberFormatter,
		async removeFromCart(productId: number, count = 1) {
			verbose(`Removing ${count} product with ID ${productId} from cart`);

			try {
				const cartAfterUpdate = await shopApi.removeProductFromCart(cart.uuid, productId, count);
				cart.overwrite(cartAfterUpdate);
			} catch (error) {
				logger(`Could not remove product ${productId} from cart:`, error);
			}
		},
		async addToCart(productId: number, count = 1) {
			verbose(`Adding ${count} product with ID ${productId} to cart`);

			try {
				const cartAfterUpdate = await shopApi.addProductToCart(cart.uuid, productId, count);
				cart.overwrite(cartAfterUpdate);
			} catch (error) {
				logger(`Could not add product ${productId} to cart:`, error);
			}
		},
		async changeCountCart(position: CartProduct, count: number) {
			verbose(`Changing count of product with ID ${position.product.id} from ${position.count} to ${count}`);

			if (count > position.count) {
				await this.addToCart(position.product.id, count - position.count);
			} else if (count < position.count) {
				await this.removeFromCart(position.product.id, position.count - count);
			} else {
				verbose(`Count of product with ID ${position.product.id} did not change`)
			}
		}
	}
};
</script>
