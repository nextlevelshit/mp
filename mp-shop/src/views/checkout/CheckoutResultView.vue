<template>
	<main class="pt-4 lg:container mx-auto px-4">
		<div class="flex gap-12 relative max-w-screen-lg mx-auto">
			<div v-if="order" class="flex flex-col gap-8 w-full">
				<div>
					<Title :level="1">Herzlichen Glückwunsch!</Title>

					<Title :level="2">Deine Bestellnummer: {{ order.id }}</Title>
				</div>

				<p class="text-lg w-2/3">In Kürze erhälst du von uns eine E-Mail mit allen Einzelheiten zu deiner
					Bestellung. Du kannst sie auch hier herunterladen, sobald sie erstellt wurde.</p>

				<div>
					<Button :is-pending="!hasReachedMaxFailedRequests && (!isReadyToDownload || isDownloadPending)"
							@click="downloadInvoice">
						<span v-if="hasReachedMaxFailedRequests">
							Bald verfügbar
						</span>
						<span v-else-if="isReadyToDownload">
							Rechnung herunterladen
						</span>
						<span v-else>
							Rechnung wird geladen
						</span>
					</Button>
					<div v-if="hasReachedMaxFailedRequests" class="text-sm mt-3">
						Es konnte noch keine Rechnung ermittelt werden. Bitte prüfe deine E-Mails oder kontaktiere uns:
						order@muellerprints.de
					</div>
				</div>

				<hr/>

				<div class="flex flex-col gap-8">
					<ul class="divide-y divide-gray-300">
						<li v-for="(position, index) in orderProducts" :key="index"
							class="py-6 gap-6 flex items-center justify-between">

							<img :src="position.product.image.url" :alt="position.product.name"
								 class="w-12 object-cover">

							<a :href="`/details/${position.product.id}`"
							   class="text-xl font-bold flex-grow">{{ position.product.name }}</a>

							<span
								class="block appearance-none w-16 text-center bg-white border border-gray-300 hover:border-gray-500 px-4 py-2 rounded shadow leading-tight focus:outline-none focus:border-indigo-500 focus:shadow-outline">
									{{ position.count }}
							</span>
						</li>
					</ul>
				</div>

				<ConfettiExplosion :colors="['#2563eb', '#ec4899', '#16a34a']"/>
			</div>

		</div>

	</main>
</template>

<script lang="ts">
import {shopApi} from "@/services/ShopApi";
import debug from "debug";
import ConfettiExplosion from "vue-confetti-explosion";
import CodeBlock from "@/components/CodeBlock.vue";
import type {Order} from "@/types";
import Header from "@/components/Header.vue";
import Stepper from "@/components/Stepper.vue";
import Title from "@/components/Title.vue";
import {numberFormatter} from "@/util/numberFormatter";
import Button from "@/components/Button.vue";
import {trackEvent} from "@/util/trackEvent";

const logger = debug("app:i:checkout-result-view");
const verbose = debug("app:v:checkout-result-view");

const maxFailedRequests = 20;

export default {
	components: {Button, Title, Stepper, Header, CodeBlock, ConfettiExplosion},
	props: ["uuid"],
	data() {
		return {
			order: {} as Order,
			isDownloadPending: false,
			failedDownloadRequests: 0,
			hasReachedMaxFailedRequests: false
		}
	},
	computed: {
		orderProducts() {
			return this.order?.cartProducts;
		},
		isReadyToDownload() {
			return !!this.order?.invoice;
		}
	},
	async mounted() {
		const fetchAndSetOrder = async () => {
			this.order = await shopApi.getOrder(this.uuid);

			if (this.order.invoice?.attributes.url) {
				return;
			}

			this.failedDownloadRequests++;

			if (this.failedDownloadRequests < maxFailedRequests) {
				verbose("Retrying to fetch invoice");
				setTimeout(fetchAndSetOrder, 3000);
			} else {
				this.hasReachedMaxFailedRequests = true;
				throw Error(`Failed to retrieve invoice after ${maxFailedRequests} attempts`);
			}
		}
		try {
			await fetchAndSetOrder();
		} catch (e) {
			verbose("Error fetching invoice:", e);
			trackEvent("checkout-result-invoice-fetch-failed");
		}
	},
	methods: {
		numberFormatter,
		downloadInvoice() {
			if (!this.isReadyToDownload) {
				verbose("Invoice not ready to download");
				return;
			}
			try {
				this.isDownloadPending = true;
				if (this.order.invoice) {
					trackEvent("checkout-result-invoice-download-succeeded");
					window.open(this.order.invoice.attributes.url, "_blank");
				} else {
					trackEvent("checkout-result-invoice-download-not-available");
					logger("Invoice URL not available");
				}
			} catch (e) {
				trackEvent("checkout-result-invoice-download-failed");
				logger("Error downloading invoice:", e);
			} finally {
				this.isDownloadPending = false;
			}
		},
	}
}
</script>
