<template>
	<main class="mt-8 mb-12 container mx-auto">
		<div class="flex gap-12 relative max-w-screen-lg mx-auto">
			<div v-if="cartProducts.length > 0" class="flex flex-col gap-8 w-full">
				<Title :level="2" html-tag="h1" classes="text-center">Im Warenkorb gesamt:
					{{ numberFormatter(cart.total) }} €</Title>

				<div class="grid place-content-center">
					<Button href="/checkout">
						Jetzt bezahlen
					</Button>
				</div>

				<hr/>

				<div class="flex flex-col gap-8">
					<ul class="divide-y divide-gray-300">
						<li v-for="(position, index) in cartProducts" :key="index"
							class="py-6 gap-6 flex items-center justify-between">

							<img :src="position.product.image.url" :alt="position.product.name"
								 class="w-12 object-cover">

							<span class="text-xl font-bold flex-grow">{{ position.product.name }}</span>

							<select
								@change="changeCountCart(position, parseInt(($event.target as HTMLInputElement).value))"
								class="block appearance-none w-16 text-center bg-white border border-gray-300 hover:border-gray-500 px-4 py-2 rounded shadow leading-tight focus:outline-none focus:border-indigo-500 focus:shadow-outline">
								<option v-for="count in 10" :selected="position.count === count" :value="count">
									{{ count }}
								</option>
							</select>

							<div class="flex flex-col gap-2 flex-end w-24">
								<span class="text-xl font-bold text-right">{{
										numberFormatter(position.product.totalProductPrice * position.count)
									}} €</span>
								<button @click="removeFromCart(position.product.id, position.count)"
										class="text-gray-500 hover:text-gray-900 hover:underline text-right">Entfernen
								</button>
							</div>
						</li>
					</ul>

					<hr/>

					<div>
						<div class="flex justify-between mb-2">
							<span class="text-2xl font-bold">Deine Gesamtsumme</span>
							<div class="flex flex-col flex-end">
								<span class="text-2xl font-bold text-right">{{ numberFormatter(cart.total) }} €</span>
								<span class="text-gray-600 text-sm text-right">Enthält MwSt. in Höhe von {{
										numberFormatter(cart.VAT)
									}} € zzgl. Versandkosten</span>
							</div>
						</div>
					</div>

					<div class="grid place-content-end">
						<Button href="/checkout" classes="w-full">
							Jetzt bezahlen
						</Button>
					</div>
				</div>
			</div>
			<div v-else class="w-full">
				<Title :level="2" html-tag="h1" classes="text-center">Dein Warenkorb ist leer.</Title>

				<div class="grid place-content-center">
					<Button href="/products">
						Entdecke unsere Produkte
					</Button>
				</div>
			</div>
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
import type {CartProduct} from "@/types";
import Title from "@/components/Title.vue";
import Button from "@/components/Button.vue";

const logger = debug("app:i:cart-view");
const verbose = debug("app:v:cart-view");

export default {
	components: {Button, Title, Header, CodeBlock},
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
