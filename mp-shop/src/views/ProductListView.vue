<template>
	<main class="pt-4 lg:container mx-auto px-4">
		<div class="flex flex-col lg:flex-row gap-12 relative">
			<aside class="lg:w-1/4">
				<div class="sticky top-4 flex flex-col gap-8">
					<section>
						<Title :level="2" html-tag="h1">Notizbücher und Notizhefte</Title>
						<p class="tracking-tight">
							Alle Notizhefte sind von uns selbst gestaltet, gedruckt und in Handarbeit gebunden. Das
							eingesetzte, matte Recyclingpapier mit feiner Textur sorgt für angenehmes Schreiben und
							Skizzieren.<br/>
							Um den Inhalt liegt ein Matelbogen aus rot durchgefärbtem Papier, was einen
							dezenten, farbigen Kontrast zu dem ansonsten absichtlich, schwarz-weiß gehaltenen Design
							setzt.
						</p>
					</section>

					<section>
						<Title :level="5" html-tag="h2">Wähle deinen Einband</Title>
						<div class="flex gap-4 justify-items-stretch mt-2">
							<SelectionBox v-for="productCover in productCovers" :label="productCover.label"
										  :aria-label="productCover.alt"
										  :path="productCover.id !== cover && productCover.url"
										  :is-active="productCover.isActive" @click="trackEvent(`product-list-sidebar-cover-clicked`)">
								<img v-if="productCover.iconUrl" :alt="productCover.alt" :src="productCover.iconUrl"/>
							</SelectionBox>
						</div>
					</section>
				</div>
			</aside>

			<div class="lg:w-3/4 grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-8">
				<ProductCard v-for="(item, i) in list" :key="i" :product="item" :cartUuid="cartUuid" />
			</div>
		</div>
	</main>
</template>
<script>
import debug from "debug";
import {shopApi} from "@/services/ShopApi";
import {localStorageLabelCartUuid} from "@/config/constants";
import ProductCard from "@/components/ProductCard.vue";
import Header from "@/components/Header.vue";
import Title from "@/components/Title.vue";
import {cart} from "@/stores/cart";
import {scrollProgress} from "@/util/scrollProgress";
import {trackEvent} from "@/util/trackEvent";
import SelectionBox from "@/components/SelectionBox.vue";

const logger = debug("app:i:product-list-view");
const verbose = debug("app:v:product-list-view");

export default {
	components: {SelectionBox, Title, Header, ProductCard},
	props: {
		cover: {
			type: String,
			required: false,
		}
	},
	data() {
		return {
			list: null,
			productCovers: null,
			hasScrolled50: false,
			hasScrolled100: false
		}
	},
	computed: {
		cart() {
			return cart;
		},
		cartUuid() {
			return cart.uuid;
		}
	},
	async mounted() {
		window.addEventListener("scroll", this.trackScrolling);

		try {
			this.list = await shopApi.getProducts(parseInt(this.cover));
		} catch (error) {
			logger("Error fetching products", error);
		}

		try {
			const productCovers = await shopApi.getProductCovers();
			this.productCovers = productCovers.map(cover => ({
				id: cover.id,
				label: cover.name,
				alt: `${cover.name} – ${cover.binding}`,
				iconUrl: cover.icon?.url,
				url: `/notebooks/${cover.id}`,
				isActive: parseInt(this.cover) === cover.id
			}));
		} catch (error) {
			logger("Error fetching product covers", error);
		}
	},
	unmounted() {
		window.removeEventListener("scroll", this.trackScrolling);
	},
	methods: {
		trackEvent,
		trackScrolling() {
			if (this.hasScrolled100) return;

			const progress = scrollProgress()

			if (progress >= 50 && !this.hasScrolled50) {
				trackEvent("product-list-scrolled-50");
				this.hasScrolled50 = true;
			}

			if (progress === 100) {
				trackEvent("product-list-scrolled-100");
				this.hasScrolled100 = true;
			}
		},
	}
}
</script>
