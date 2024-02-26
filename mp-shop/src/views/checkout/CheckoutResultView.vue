<template>
	<main class="container mx-auto">
		<div v-if="order">
			<div class="mt-8 mb-12 flex gap-8 mx-auto relative">
				<div class="w-1/2 flex flex-col gap-6">
					<div>
						<Title :level="1">Herzlichen Glückwunsch!</Title>

						<Title :level="2">Deine Bestellnummer: {{order.id}}</Title>
					</div>

					<p>In Kürze erhälst du von uns eine E-Mail mit allen Einzelheiten zu deiner Bestellung. Du hast jedoch vorab die Möglichkeit die Rechnung direkt herunterzuladen.</p>

					<div>
						<Button classes="w-full" :is-pending="isDownloadPending" @click="downloadInvoice">
							Rechnung herunterladen
						</Button>
					</div>
				</div>
				<div class="w-1/2">
					<div v-if="orderProducts" class="flex flex-col gap-8">
						<ul class="divide-y divide-gray-300">
							<li v-for="(position, index) in orderProducts" :key="index"
								class="py-6 gap-6 flex items-center justify-between">

								<img :src="position.product.image.url" :alt="position.product.name"
									 class="w-6 object-cover">

								<span class="text-sm flex-grow">{{ position.product.name }}</span>

								<div
									class="block text-center bg-white border border-gray-300 px-4 py-2 rounded shadow leading-tight">
									{{ position.count }}
								</div>

<!--								<div class="flex flex-col gap-2 flex-end w-24">-->
<!--									<span class="text-sm font-bold text-right">{{-->
<!--											numberFormatter(position.product.totalProductPrice * position.count)-->
<!--										}} €</span>-->
<!--								</div>-->
							</li>
						</ul>


<!--						<div>-->
<!--							<div class="flex justify-between mb-2">-->
<!--								<span class="text-2xl">Zwischensumme</span>-->
<!--								<span class="text-2xl">{{ numberFormatter(order.total) }} €</span>-->
<!--							</div>-->
<!--							<div class="flex justify-between mb-2">-->
<!--								<span class="text-2xl">Versand</span>-->
<!--								<span class="text-2xl">{{ order.delivery?.price ? numberFormatter(order.delivery.price, "€") : "KOSTENFREI" }}</span>-->
<!--							</div>-->
<!--							<div class="flex justify-between mb-2">-->
<!--								<span class="text-2xl font-bold">Gesamtsumme</span>-->
<!--								<div class="flex flex-col flex-end">-->
<!--									<span class="text-2xl font-bold text-right">-->
<!--										{{ numberFormatter(order.total) }} €-->
<!--									</span>-->
<!--									<span class="text-gray-600 text-sm text-right">-->
<!--										inkl. MwSt. {{ numberFormatter(order.VAT) }} €-->
<!--									</span>-->
<!--								</div>-->
<!--							</div>-->
<!--						</div>-->
					</div>


					<div class="bg-gray-100 mt-2 p-8 text-gray-700 rounded-lg">
						<div class="text-lg">
							<Title :level="3">E-Mail-Adresse:</Title>
							<p>{{ order.email }}</p>
						</div>

						<div class="mt-4">
							<Title :level="3">Rechnungsadresse:</Title>
							<p class="text-lg whitespace-pre-line" v-html="order.invoiceAddress"/>
						</div>

						<div v-if="order.address" class="mt-4">
							<Title :level="3">Lieferadresse:</Title>
							<p class="text-lg whitespace-pre-line" v-html="order.address"/>
						</div>
					</div>
				</div>
			</div>
		</div>
	</main>
</template>

<script lang="ts">
import {shopApi} from "@/services/ShopApi";
import debug from "debug";
import CodeBlock from "@/components/CodeBlock.vue";
import type {Order} from "@/types";
import Header from "@/components/Header.vue";
import Stepper from "@/components/Stepper.vue";
import Title from "@/components/Title.vue";
import {numberFormatter} from "@/util/numberFormatter";
import Button from "@/components/Button.vue";

const logger = debug("app:i:checkout-result-view");
const verbose = debug("app:v:checkout-result-view");

export default {
	components: {Button, Title, Stepper, Header, CodeBlock},
	props: ["uuid"],
	data() {
		return {
			order: {} as Order,
			isDownloadPending: false
		}
	},
	computed: {
		orderProducts() {
			return this.order?.cartProducts;
		}
	},
	async mounted() {
		try {
			this.order = await shopApi.getOrder(this.uuid);
		} catch (e) {
			verbose("Could not fetch checkout status");
		}
	},
	methods: {
		numberFormatter,
		downloadInvoice() {
			try {
				this.isDownloadPending = true;
				if (this.order.invoice) {
					window.open(this.order.invoice.attributes.url, "_blank");
				} else {
					logger("Invoice URL not available");
				}
			} catch (e) {
				logger("Error downloading invoice:", e);
			} finally {
				this.isDownloadPending = false;
			}
		},
	}
}
</script>
