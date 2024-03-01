<template>
	<main class="container mx-auto">
		<Stepper :step="3"/>

		<div v-if="cart">
			<div class="mt-8 mb-12 flex gap-8 mx-auto relative">
				<div class="w-1/2">
					<div v-if="!hasPaymentError" class="payment sticky top-4" ref="payment"></div>
					<div v-else class="p-8 text-center mx-auto rounded-md bg-rose-100 b">
						<span class="text-rose-800">Es ist ein Fehler aufgetreten. Bitte versuche es erneut.</span>
					</div>
				</div>
				<div class="w-1/2">
					<div v-if="cartProducts" class="flex flex-col gap-8">
						<ul class="divide-y divide-gray-300">
							<li v-for="(position, index) in cartProducts" :key="index"
								class="py-6 gap-6 flex items-center justify-between">

								<img :src="position.product.image.url" :alt="position.product.name"
									 class="w-6 object-cover">

								<span class="text-xl flex-grow">{{ position.product.name }}</span>

								<div
									class="block text-center bg-white border border-gray-300 px-4 py-2 rounded shadow leading-tight">
									{{ position.count }}
								</div>

								<div class="flex flex-col gap-2 flex-end w-24">
									<span class="text-xl text-right">{{
											numberFormatter(position.product.totalProductPrice * position.count)
										}} €</span>
								</div>
							</li>
						</ul>

						<hr/>

						<div>
							<div class="flex justify-between mb-2">
								<span class="text-2xl">Zwischensumme</span>
								<span class="text-2xl">{{ numberFormatter(cart.total) }} €</span>
							</div>
							<div class="flex justify-between mb-2">
								<span class="text-2xl">Versand</span>
								<span class="text-2xl">{{
										cart.delivery?.price ? numberFormatter(cart.delivery.price, "€") : "KOSTENFREI"
									}}</span>
							</div>
							<div class="flex justify-between mb-2">
								<span class="text-2xl font-bold">Gesamtsumme</span>
								<div class="flex flex-col flex-end">
									<span class="text-2xl font-bold text-right">
										{{ numberFormatter(cart.total) }} €
									</span>
									<span class="text-gray-600 text-sm text-right">
										inkl. MwSt. {{ numberFormatter(cart.VAT) }} €
									</span>
								</div>
							</div>
						</div>
					</div>


					<div class="bg-gray-100 mt-10 p-8 text-gray-700 rounded-lg relative">
						<div class="text-lg">
							<Title :level="3">Kontaktinformationen</Title>
							<p>{{ cart.email }}</p>
						</div>
						<a href="/checkout/1" @click="trackEvent(`checkout-payment-change-email-address-clicked`)" class="absolute bottom-8 right-12 hover:underline underline-offset-2">Ändern</a>
					</div>

					<div class="bg-gray-100 mt-10 p-8 text-gray-700 rounded-lg relative">
						<Title :level="3">Rechnungsadresse:</Title>
						<p class="text-lg whitespace-pre-line" v-html="cart.invoiceAddress"/>
						<a href="/checkout/2" @click="trackEvent(`checkout-payment-change-invoice-address-clicked`)" class="absolute bottom-8 right-12 hover:underline underline-offset-2">Ändern</a>
					</div>

					<div v-if="cart.address" class="bg-gray-100 mt-10 p-8 text-gray-700 rounded-lg relative">
						<Title :level="3">Lieferadresse:</Title>
						<p class="text-lg whitespace-pre-line" v-html="cart.address"/>
						<a href="/checkout/2" @click="trackEvent(`checkout-payment-change-delivery-address-clicked`)" class="absolute bottom-8 right-12 hover:underline underline-offset-2">Ändern</a>
					</div>

					<div class="bg-gray-100 mt-10 p-8 text-gray-700 rounded-lg">
						<div>
							<Title :level="4">
								Sicherheitsabfrage bei Kreditkartenzahlung
							</Title>
							<p class="text-sm mt-1">Möglicherweise werden Sie im nächsten Schritt von Ihrer Bank
								gebeten, Ihre
								Kreditkarte zu verifizieren (3-D Secure).</p>
							<Title :level="4">Hinweise zum Datenschutz</Title>
							<p class="mt-1 text-sm">Die personenbezogenen Daten werden für die Abwicklung der Bestellung
								automatisiert verarbeitet. Der Schutz Ihrer persönlichen Daten ist uns wichtig. Daher
								verwenden wir bei der Übertragung moderne Verschlüsselungstechnologien. Weiteres
								entnehmen
								Sie bitte unseren <a href="/privacy" target="_blank" class="underline">Datenschutzhinweisen</a>.
							</p>
						</div>
					</div>
				</div>
			</div>
		</div>
	</main>
</template>

<script lang="ts">
import debug from "debug";
import AdyenCheckout from "@adyen/adyen-web";
import "@adyen/adyen-web/dist/adyen.css";
import CodeBlock from "@/components/CodeBlock.vue";
import {shopApi} from "@/services/ShopApi";
import type {Order} from "@/types";
import {cart} from "@/stores/cart";
import Stepper from "@/components/Stepper.vue";
import Header from "@/components/Header.vue";
import Title from "@/components/Title.vue";
import {numberFormatter} from "@/util/numberFormatter";
import {paymentEnvironment} from "@/config/constants";
import {trackEvent} from "@/util/trackEvent";

const logger = debug("app:i:checkout-view");
const verbose = debug("app:v:checkout-view");

export default {
	components: {Header, Stepper, CodeBlock, Title},
	computed: {
		uuid() {
			return cart.uuid
		},
		cartProducts() {
			return this.cart?.cartProducts;
		}
	},
	data() {
		return {
			cart: {} as Order | null,
			hasPaymentError: false
		}
	},
	async mounted() {
		const urlParams = new URLSearchParams(window.location.search);
		const sessionId = urlParams.get("sessionId");
		const redirectResult = urlParams.get("redirectResult");

		logger(paymentEnvironment);

		try {
			this.cart = await shopApi.getOrder(this.uuid);

			if (!this.cart) {
				verbose("Could not fetch cart with ID:", this.uuid);
				return;
			}

			if (sessionId) {
				await this.finalizeCheckout(sessionId, redirectResult!);
			} else {
				await this.startCheckout();
			}
		} catch (error) {
			verbose("Error fetching or creating cart:", error);
		}
	},
	methods: {
		trackEvent,
		numberFormatter,
		async startCheckout() {
			verbose("SessionId not found, initilizing checkout");
			if (!this.cart) {
				verbose("Cart not found, cannot initilize checkout");
				return;
			}
			this.hasPaymentError = false;
			try {
				const {session, clientKey} = await shopApi.checkoutOrder(this.cart.uuid);
				const checkout = await this.createAdyenCheckout(session, clientKey);
				checkout.create("dropin").mount(this.$refs["payment"]);
			} catch (error) {
				verbose("Error initializing checkout:", error);
				this.hasPaymentError = true;
				trackEvent("checkout-payment-start-failed");
			}
		},
		async finalizeCheckout(id: string, details: string) {
			verbose("SessionId found, finilizing checkout");
			const checkout = await this.createAdyenCheckout({id});
			checkout.submitDetails({details});
		},
		async createAdyenCheckout(session: any, clientKey?: string): Promise<any> {
			if (!this.cart) {
				logger("Cart not found, cannot create checkout");
				return;
			}
			const configuration = {
				clientKey,
				session,
				analytics: {
					enabled: false
				},
				locale: "de_DE",
				environment: paymentEnvironment,
				showPayButton: true,
				paymentMethodsConfiguration: {
					card: {
						hasHolderName: true,
						holderNameRequired: true,
						name: "Kreditkarte oder Debitkarte",
						amount: {
							currency: session.amount.currency || "EUR",
							value: session.amount.value || Math.round(this.cart.total * 100)
						}
					},
					paypal: {
						amount: {
							currency: session.amount.currency || "EUR",
							value: session.amount.value || Math.round(this.cart.total * 100)
						},
						environment: paymentEnvironment,
						countryCode: "DE"   // Only needed for test. This will be automatically retrieved when you are in production.
					}
				},
				onPaymentCompleted: async (result: any, component: any) => {
					await this.handleCheckoutResponse(result, component);
				},
				onError: (error: any, component: any) => {
					logger("Creating checkout failed");
					trackEvent("checkout-payment-create-failed");
					verbose(error.name, error.message, error.stack, component);
				}
			};
			return AdyenCheckout(configuration);
		},
		async handleCheckoutResponse(res: any, component: any) {
			verbose("Handling checkout response:", res);
			if (!this.cart) {
				logger("Cart not found, cannot proceed");
				return;
			}

			const {uuid} = this.cart;

			if (res.action) {
				component.handleAction(res.action);
			} else {
				switch (res.resultCode) {
					case "Authorised":
						trackEvent("checkout-payment-authorised");
						await shopApi.finalizeOrder(uuid);
						trackEvent("checkout-payment-finalized");
						window.location.assign(`/checkout/result/${uuid}`);
						break;
					case "Pending":
					case "Received":
						await shopApi.updateOrder(uuid, {
							paymentStatus: "pending"
						});
						trackEvent("checkout-payment-pending");
						verbose("Order pending");
						break;
					case "Refused":
						await shopApi.updateOrder(uuid, {
							paymentStatus: "refused"
						});
						trackEvent("checkout-payment-refused");
						verbose("Order refused");
						break;
					default:
						await shopApi.updateOrder(uuid, {
							paymentStatus: "error"
						});
						trackEvent("checkout-payment-error");
						break;
				}
			}
		}
	}
}
</script>
