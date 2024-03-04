<template>
	<main class="pt-4 px-4 lg:container mx-auto">
		<div v-if="markdown" class="markdown lg:w-3/4">
			<VueMarkdown :source="markdown"/>
		</div>

		<aside class="lg:w-3/4">
			<div v-if="paymentMethods.length > 0">
				<Title :level="2" html-tag="h2">Zahlungsmethoden</Title>

				<ul>
					<li v-for="method in paymentMethods" :key="method.id">
						<Title :level="3" html-tag="h3">{{ method.name }}</Title>
						<P>{{ method.description }}</p>
					</li>
				</ul>
			</div>

			<div v-if="deliveryMethods.length > 0">
				<Title :level="2" html-tag="h2">Lieferarten</Title>
				<ul>
					<li v-for="method in deliveryMethods" :key="method.id">
						<Title :level="3" html-tag="h3">{{ method.name }}</Title>
						<p>{{ method.description }}</p>
					</li>
				</ul>
			</div>
		</aside>
	</main>
</template>

<script lang="ts">
import {defineComponent, type PropType} from "vue";
import debug from "debug";
import {shopApi} from "@/services/ShopApi";
import type {LegalPage, PaymentMethod, DeliveryMethod} from "@/types";
import VueMarkdown from "vue-markdown-render/src/VueMarkdown";
import Title from "@/components/Title.vue";

const logger = debug("app:i:legal-view");
const verbose = debug("app:v:legal-view");

export default defineComponent({
	components: {VueMarkdown, Title},
	data() {
		return {
			markdown: "",
			deliveryMethods: {} as DeliveryMethod[],
			paymentMethods: {} as PaymentMethod[],
		}
	},
	props: {
		content: {
			type: String as PropType<LegalPage>,
			required: true,
		}
	},
	mounted: async function () {
		try {
			const data = await shopApi.getLegal();
			this.markdown = data[this.content];
		} catch (e) {
			verbose("Error fetching legal page", e);
		}

		try {
			switch (this.content) {
				case "payment":
					this.paymentMethods = await shopApi.getPaymentMethods();
					break;
				case "delivery":
					this.deliveryMethods = await shopApi.getDeliveryMethods();
					break;
			}
		} catch (e) {
			verbose("Error fetching payment or delivery or payment methods", e);
		}
	},
})
</script>

<style>
.markdown h1 {
	@apply text-3xl font-bold mb-5 mt-6;
}

.markdown h2 {
	@apply text-2xl font-bold mb-4 mt-5;
}

.markdown h3 {
	@apply text-xl mt-2 font-semibold mb-1;
}

.markdown ul {
	@apply list-disc pl-6;
}

.markdown p + p {
	@apply mt-4;
}

.markdown a {
	@apply underline-offset-2 underline hover:text-gray-700;
}
</style>
