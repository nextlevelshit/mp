<template>
	<a
		:href="`/details/${product.id}`"
		class="gap-2 flex flex-col group hover:scale-110 transition-all"
		@click="
			trackEvent(`product-card-clicked`, {
				product: product.id,
				price: product.totalProductPrice
			})
		"
	>
		<div
			:class="[bgColor, shadowColor]"
			class="p-12 flex items-center justify-center rounded-sm shadow-2xl group-active:shadow-none"
		>
			<img
				:src="product.image.url"
				:alt="product.name"
				class="lg:w-full object-cover max-h-64 lg:max-h-fit"
			/>
		</div>
		<div class="flex flex-col justify-between">
			<div class="px-2 py-4">
				<p class="text-gray-900">{{ product.pattern?.name }}</p>
				<p class="text-gray-600">
					ab {{ numberFormatter(product.totalProductPrice, "€") }}
				</p>
			</div>
		</div>
	</a>
</template>

<script lang="ts">
import debug from "debug";
import { randomTailwindColor } from "@/util/randomTailwindColor";
import type { Product } from "@/types";
import type { PropType } from "vue";
import { numberFormatter } from "@/util/numberFormatter";
import { trackEvent } from "@/util/trackEvent";

const logger = debug("app:i:product-card");
const verbose = debug("app:v:product-card");

export default {
	data() {
		return {
			isAddingToCart: false
		};
	},
	props: {
		product: {
			type: Object as PropType<Product>,
			required: true
		},
		cartUuid: {
			type: String,
			required: true
		}
	},
	computed: {
		bgColor() {
			return this.product?.pattern && randomTailwindColor(this.product.pattern.id);
		},
		shadowColor() {
			return (
				this.product?.pattern &&
				randomTailwindColor(this.product.pattern.id, "shadow", 200, "/60")
			);
		}
	},
	methods: {
		trackEvent,
		numberFormatter
	}
};
</script>
