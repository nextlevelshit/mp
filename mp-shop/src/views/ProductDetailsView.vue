<template>
	<article :class="bgColor" class="shadow-inner" itemscope itemtype="https://schema.org/Product">
		<main class="pt-12 px-4 lg:container mx-auto">
			<div v-if="product">
				<p class="text-gray-800 text-lg">{{product.cover?.copyText?.format}}</p>
				<Title :level="1" html-tag="h1" classes="xl:w-2/3">
					<span v-html="product.cover?.copyText?.details" class=""></span>
				</Title>
				<p class="text-gray-800 text-lg lg:w-4/5">{{product.cover?.copyText?.paper}}</p>
				<!--    <h1 class="text-2xl font-bold mb-4">{{ product.name }} - Product ID: {{ id }}</h1>-->
				<div class="flex flex-col-reverse lg:flex-row gap-12 relative">
					<div class="lg:w-1/2 xl:w-2/5 pt-8">
						<div class="rounded-lg bg-white shadow-xl mb-16">
							<section class="flex flex-col xl:flex-row gap-4 xl:gap-12 py-6 px-4 xl:px-8">
								<h2 class="pt-3 xl:w-1/3 uppercase text-gray-500 text-sm font-semibold">Einband</h2>
								<div class="flex xl:w-2/3 gap-4">
									<SelectionBox v-for="cover in productVariantsCover" :label="cover.name"
												  :path="cover.productId &&`/details/${cover.productId}`"
												  :is-active="cover.productId === product.id" @click="trackEvent(`product-change-cover-clicked`, { product: product.id, label: cover.name })">
										<img v-if="cover.iconUrl" :alt="cover.name" :src="cover.iconUrl"/>
									</SelectionBox>
								</div>
							</section>
							<hr class="border-t-[1px] border-gray-300"/>
							<section class="flex flex-col xl:flex-row gap-4 xl:gap-12 py-6 px-4 xl:px-8">
								<h2 class="pt-3 xl:w-1/3 uppercase text-gray-500 text-sm font-semibold">Layout</h2>
								<div class="flex xl:w-2/3 gap-4">
									<SelectionBox v-for="ruling in productVariantsRuling" :label="ruling.name"
												  :path="ruling.productId && `/details/${ruling.productId}`"
												  :is-active="ruling.productId === product.id" @click="trackEvent(`product-change-ruling-clicked`, { product: product.id, label: ruling.name })">
										<img v-if="ruling.iconUrl" :alt="ruling.name" :src="ruling.iconUrl"/>
									</SelectionBox>
								</div>
							</section>
							<hr class="border-t-[1px] border-gray-300"/>
							<section class="flex flex-col xl:flex-row gap-4 xl:gap-12 py-6 px-4 xl:px-8">
								<h2 class="pt-3 xl:w-1/3 uppercase text-gray-500 text-sm font-semibold">Seitenanzahl</h2>
								<div class="flex xl:w-2/3 gap-4">
									<SelectionBox v-for="pages in productVariantsPages" :label="pages.name"
												  :path="pages.productId && `/details/${pages.productId}`"
												  :is-active="pages.productId === product.id" @click="trackEvent(`product-change-pages-clicked`, { product: product.id, label: pages.name })"/>
								</div>
							</section>
							<hr class="border-t-[1px] border-gray-300"/>
							<section class="flex gap-12 py-6 px-4 lg:px-8 items-center">
								<div class="w-1/3" itemprop="offers" itemscope itemtype="http://schema.org/Offer">
									<meta itemprop="priceCurrency" content="EUR"/>
									<span itemprop="price" class="oldstyle-nums text-3xl tracking-tight font-bold">
										{{ numberFormatter(product.totalProductPrice) }} €
									</span>
								</div>
								<div class="w-2/3">
									<Button @click="addToCart"
											:is-pending="isAddingToCart"
											classes="w-full">
										In den Warenkorb
									</Button>
								</div>
							</section>
						</div>

						<!-- CopyText Details -->
						<div v-if="product.cover?.copyText" class="my-16 px-4 flex flex-col gap-y-6">
							<div v-html="product.cover.copyText.text"></div>
							<p><span class="font-bold">Einband:</span> {{ product.cover.copyText.cover }}</p>
							<p><span class="font-bold">Papier:</span> {{ product.cover.copyText.paper }}</p>
							<p><span class="font-bold">Format:</span> {{ product.cover.copyText.format }}</p>
							<p><span class="font-bold">Banderole:</span> {{ product.cover.copyText.banderole }}</p>
						</div>
					</div>
					<div class="flex justify-center lg:w-1/2 xl:w-3/5 pt-8 mx-auto">
						<!-- Product Image -->
						<div class="w-2/5">
							<VueMagnifier v-if="product.image" zoom-factor="1" mg-height="300" mg-width="300"
										  :src="product.image.url" :alt="product.name" class-name="w-full object-cover"
										  itemprop="image"/>
						</div>
					</div>
				</div>
			</div>
		</main>
	</article>
	<section class="flex flex-col gap-8 px-4 lg:container mx-auto items-center my-10" v-if="patternVariants.patterns">
		<div class="">
			<Title :level="1" html-tag="h2">Erhältlich in {{ patternVariants.patterns.length }} weiteren Mustern</Title>
		</div>

		<ul class="grid grid-cols-1 lg:grid-cols-5 gap-12">
			<li v-for="(pattern, i) in patternVariants.patterns" :key="i" @click="trackEvent(`product-details-pattern-clicked`, { product: product.id, pattern: pattern.id})">
				<a :href="pattern.productVariant?.id ? `/details/${pattern.productVariant.id}` : ``"
				   class="block hover:opacity-40 h-60 w-60 rounded-full shadow-lg border-6 border-white"
				   :style="`background: url(${pattern.image.url}) no-repeat; background-size: cover;`">
				</a>
			</li>
		</ul>
	</section>
</template>

<script lang="ts">
import CodeBlock from "@/components/CodeBlock.vue";
import type {Product, ProductVariantResponse, PatternVariantsResponse} from "@/types";
import {shopApi} from "@/services/ShopApi";
import debug from "debug";
import {cart} from "@/stores/cart";
import {randomTailwindColor} from "@/util/randomTailwindColor";
import Header from "@/components/Header.vue";
import {numberFormatter} from "@/util/numberFormatter";
import SelectionBox from "@/components/SelectionBox.vue";
import VueMagnifier from "@websitebeaver/vue-magnifier";
import "@websitebeaver/vue-magnifier/styles.css";
import Button from "@/components/Button.vue";
import Title from "@/components/Title.vue";
import {trackEvent} from "@/util/trackEvent";
import {scrollProgress} from "@/util/scrollProgress";

const logger = debug("app:i:product-details-view");
const verbose = debug("app:v:product-details-view");

export default {
	components: {Button, SelectionBox, Header, CodeBlock, VueMagnifier, Title},
	props: ["id"],
	computed: {
		uuid() {
			return cart.uuid;
		},
		bgColor() {
			if (this.product.pattern) {
				return randomTailwindColor(this.product.pattern.id, "bg", 100);
			} else {
				return "bg-gray-200";
			}
		},
		productVariantsRuling() {
			if (!this.productVariants.ruling) return;

			return this.productVariants.ruling.map(({name, icon, productVariant}) => {
				return {
					name,
					iconUrl: icon?.url,
					productId: productVariant?.id
				}
			});
		},
		productVariantsPages() {
			if (!this.productVariants.pages) return;

			return this.productVariants.pages.map(({name, productVariant}) => {
				return {
					name,
					productId: productVariant?.id
				}
			});
		},
		productVariantsCover() {
			if (!this.productVariants.cover) return;

			return this.productVariants.cover.map(({name, icon, productVariant}) => {
				return {
					name,
					iconUrl: icon?.url,
					productId: productVariant?.id
				}
			});
		}
	},
	data() {
		return {
			product: {} as Product,
			productVariants: {} as ProductVariantResponse,
			patternVariants: {} as PatternVariantsResponse,
			isAddingToCart: false,
			hasScrolled50: false,
			hasScrolled100: false
		}
	},
	async mounted() {
		window.addEventListener("scroll", this.trackScrolling);
		try {
			this.product = await shopApi.getProductById(this.id);
		} catch (e) {
			logger("Could not fetch product");
			verbose(e);
		}
		try {
			this.productVariants = await shopApi.getProductVariantsByProductId(this.id);
			logger(this.productVariants);
		} catch (e) {
			logger("Could not fetch product variants");
			verbose(e);
		}
		try {
			this.patternVariants = await shopApi.getPatternVariantsByProductId(this.id);
			logger(this.productVariants);
		} catch (e) {
			logger("Could not fetch product variants");
			verbose(e);
		}
	},
	unmounted() {
		window.removeEventListener("scroll", this.trackScrolling);
	},
	methods: {
		trackEvent,
		numberFormatter,
		trackScrolling() {
			if (this.hasScrolled100) return;

			const progress = scrollProgress()

			if (progress >= 50 && !this.hasScrolled50) {
				trackEvent("product-details-scrolled-50");
				this.hasScrolled50 = true;
			}

			if (progress === 100) {
				trackEvent("product-details-scrolled-100");
				this.hasScrolled100 = true;
			}
		},
		async addToCart() {
			verbose(`Adding product with ID ${this.product.id} to cart`);

			trackEvent(`product-details-add-to-cart-clicked`, { product: this.product.id, price: this.product.totalProductPrice });

			try {
				this.isAddingToCart = true;
				await shopApi.addProductToCart(this.uuid, this.product.id);
				trackEvent(`product-details-add-to-cart-succeeded`, { product: this.product.id });
				window.location.assign("/cart");
			} catch (error) {
				logger(`Could not add product ${this.product.id} to cart:`, error);
				trackEvent(`product-details-add-to-cart-failed`, { product: this.product.id });
			} finally {
				this.isAddingToCart = false;
			}
		}
	},
}
</script>
