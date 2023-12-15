<script src="../../../mp-shop-api/src/router.ts"></script>
<script>
import { depotApi } from "@/services/DepotApi";
import debug from "debug";
import { OrderViewDto } from "@/dto/OrderViewDto";

export default {
	props: ["id"],
	data() {
		return {
			error: null,
			order: {},
			isGeneratingInvoice: false,
			isGeneratingDeliveryNote: false,
			isUpdatingForm: false,
			hasChanges: true,
			pdfUrl: null,
			logger: debug("app:i:order-view"),
			defaultPdfData: {
				currency: "\\euro",
				body: "**Gewählte Zahlungsart:** PayPal\n\nDie Rechnung wurde per **PayPal** bereits beglichen.\n\nVielen Dank für Ihren Einkauf"
			},
			deliveryOptions: [],
			paymentOptions: []
		};
	},
	mounted() {
		this.logger(`Edit order with Id "${this.id}"`);

		this.fetchOrder();
		this.fetchDeliveryOptions();
		this.fetchPaymentOptions();
	},
	methods: {
		fetchDeliveryOptions() {
			depotApi.delivery().then((options) => {
				this.deliveryOptions = options;
			});
		},
		fetchPaymentOptions() {
			depotApi.payment().then((options) => {
				this.paymentOptions = options;
			});
		},
		fetchOrder() {
			if (this.id) {
				depotApi.orderFactory().one(this.id).then(this.fillForm);
			} else {
				this.logger("Id not provided, creating new order");
			}
		},
		fillForm(data) {
			// this.orderData = data;
			// this.formData = OrderListDto.toFormInput(data);
			this.order = new OrderViewDto(data);
		},
		save() {
			this.logger("Saving form data");
			this.isUpdatingForm = true;

			// const { total, subtotal, VAT, delivery, payment } = this.orderData.attributes;

			const data = this.order.data;

			const body = new FormData();
			body.append("data", JSON.stringify(data));

			this.logger(data);

			depotApi
				.orderFactory()
				.update(this.id, body)
				.then((data) => {
					setTimeout(() => {
						this.isUpdatingForm = false;
					}, 711);
				})
				.finally(() => {});
		},
		generateDeliveryNote() {
			this.logger(this.order.raw);
			this.order.resetDeliveryNote();

			const data = {
				...this.defaultPdfData,
				subject: "LIEFERSCHEIN",
				date: new Date(this.order.data.Date).toLocaleDateString(),
				// shipping: this.order.raw.attributes.delivery.data.attributes.price,
				// VAT: {
				// 	rate: 19,
				// 	amount: this.order.raw.attributes.VAT
				// },
				// subtotal: this.order.data.subtotal,
				// total: this.order.data.total,
				to: {
					name: "",
					address: this.order.data.address.split("\n")
				},
				nr: {
					customer: this.order.nr.customer,
					order: this.order.nr.order,
					shipping: this.order.nr.shipping
				},
				service: this.order.products.map((product) => ({
					description: product.attributes.name,
					price: {
						per_unit: product.attributes.cover.data.attributes.price,
						total: product.attributes.cover.data.attributes.price
					},
					count: 1,
					nr: product.id
				}))
			};

			this.logger(data);
			this.isGeneratingDeliveryNote = true;

			fetch("/api/mp-inkasso/v1/invoice", {
				method: "POST",
				headers: {
					"Content-Type": "application/json"
				},
				body: JSON.stringify(data)
			})
				.then((response) => {
					if (response.ok) {
						return response.blob();
					} else {
						throw new Error("Error generating PDF");
					}
				})
				.then((blob) => {
					// Display the generated PDF in an iframe
					this.pdfUrl = URL.createObjectURL(blob);

					this.logger(`Delivery note PDF generated at: ${this.pdfUrl}`);

					const body = new FormData();

					body.append("files.deliveryNote", blob);
					body.append("data", JSON.stringify(this.order.data));

					return depotApi
						.orderFactory()
						.update(this.id, body)
						.then((data) => {
							this.logger(data.attributes.deliveryNote);
							this.order = new OrderViewDto(data);
						});
				})
				.catch((error) => {
					this.logger(error);
				})
				.finally(() => {
					this.isGeneratingDeliveryNote = false;
				});
		},
		generateInvoicePdf() {
			this.logger(this.order.raw);
			this.order.resetInvoice();
			this.isGeneratingInvoice = true;

			const { customer, order, invoice } = this.order.nr;
			const { subtotal, total } = this.order.data;

			const data = {
				...this.defaultPdfData,
				subject: "RECHNUNG",
				date: new Date(this.order.data.Date).toLocaleDateString(),
				shipping: this.order.raw.attributes.delivery.data.attributes.price,
				VAT: {
					rate: 19,
					amount: this.order.raw.attributes.VAT
				},
				subtotal,
				total,
				to: {
					name: "",
					address: this.order.data.invoiceAddress.split("\n")
				},
				nr: {
					customer,
					order,
					invoice
				},
				service: this.order.products.map((product) => ({
					description: product.attributes.name,
					price: {
						per_unit: product.attributes.cover.data.attributes.price,
						total: product.attributes.cover.data.attributes.price
					},
					count: 1,
					nr: product.id
				}))
			};

			this.logger(data);

			fetch("/api/mp-inkasso/v1/invoice", {
				method: "POST",
				headers: {
					"Content-Type": "application/json"
				},
				body: JSON.stringify(data)
			})
				.then((response) => {
					if (response.ok) {
						return response.blob();
					} else {
						throw new Error("Error generating PDF");
					}
				})
				.then((blob) => {
					// Display the generated PDF in an iframe
					this.pdfUrl = URL.createObjectURL(blob);

					this.logger(`Invoice PDF generated at: ${this.pdfUrl}`);

					const body = new FormData();

					body.append("files.invoice", blob);
					body.append("data", JSON.stringify(this.order.data));

					this.logger(body);

					return depotApi
						.orderFactory()
						.update(this.id, body)
						.then((data) => {
							this.logger(data.attributes.invoice);
							this.order = new OrderViewDto(data);
						});
				})
				.catch((error) => {
					this.logger(error);
				})
				.finally(() => {
					this.isGeneratingInvoice = false;
				});
		}
	}
};
</script>

<template>
	<!--	<pre class="container mx-auto">{{ JSON.stringify(order, null, 2) }}</pre>-->
	<section v-if="true" class="container mx-auto relative flex flex-col gap-4">
		<h1 class="font-semibold text-2xl mb-6">
			{{ order.data.Date }}
			<span class="font-light">(ID: {{ order.raw.id }})</span>
		</h1>
		<button
			v-if="hasChanges"
			@click="save()"
			class="absolute top-0 right-0 flex items-center justify-center w-1/2 px-5 py-2 text-sm tracking-wide text-white transition-colors duration-200 bg-blue-500 rounded-lg shrink-0 sm:w-auto gap-x-2 hover:bg-blue-600 dark:hover:bg-blue-500 dark:bg-blue-600"
		>
			<svg
				xmlns="http://www.w3.org/2000/svg"
				fill="none"
				viewBox="0 0 24 24"
				stroke-width="1.5"
				stroke="currentColor"
				class="w-5 h-5"
			>
				<path
					stroke-linecap="round"
					stroke-linejoin="round"
					d="M12 9v6m3-3H9m12 0a9 9 0 11-18 0 9 9 0 0118 0z"
				/>
			</svg>

			<span v-if="isUpdatingForm">Wird gespeichert...</span>
			<span v-else>Speichern</span>
		</button>
		<fieldset class="flex gap-2 hidden">
			<div class="w-1/5">
				<label
					for="nr-order"
					class="block text-sm font-medium leading-6 text-gray-900"
					>Bestellnr.</label
				>
				<div class="relative mt-2 rounded-md shadow-sm">
					<input
						v-model="order.nr.order"
						type="text"
						name="nr-order"
						id="nr-order"
						class="block w-full rounded-md border-0 py-1.5 px-2 text-gray-900 ring-1 ring-inset ring-gray-300 placeholder:text-gray-400 focus:ring-2 focus:ring-inset focus:ring-indigo-600 sm:text-sm sm:leading-6"
						disabled
					/>
				</div>
			</div>
			<div class="w-1/5">
				<label
					for="nr-customer"
					class="block text-sm font-medium leading-6 text-gray-900"
					>Kundennr.</label
				>
				<div class="relative mt-2 rounded-md shadow-sm">
					<input
						v-model="order.nr.customer"
						type="text"
						name="nr-customer"
						id="nr-customer"
						class="block w-full rounded-md border-0 py-1.5 px-2 text-gray-900 ring-1 ring-inset ring-gray-300 placeholder:text-gray-400 focus:ring-2 focus:ring-inset focus:ring-indigo-600 sm:text-sm sm:leading-6"
						disabled
					/>
				</div>
			</div>
			<div class="w-3/5"></div>
		</fieldset>
		<div class="flex gap-12 my-8">
			<!--      <div class="w-full">-->
			<!--        Full-->
			<!--      </div>-->
			<div class="flex flex-col gap-2 w-1/6">
				<div class="">
					<label
						for="total"
						class="block text-sm font-medium leading-6 text-gray-900"
						>Gesamtpreis</label
					>
					<div class="relative mt-2 rounded-md shadow-sm">
						<div
							class="pointer-events-none absolute inset-y-0 left-0 flex items-center pl-3"
						>
							<span class="text-gray-500 sm:text-sm">€</span>
						</div>
						<input
							v-model="order.data.total"
							type="text"
							name="total"
							id="total"
							class="block w-full rounded-md border-0 py-1.5 pl-7 pr-20 text-gray-900 ring-1 ring-inset ring-gray-300 placeholder:text-gray-400 focus:ring-2 focus:ring-inset focus:ring-indigo-600 sm:text-sm sm:leading-6"
							placeholder="0.00"
						/>
					</div>
				</div>
				<div class="">
					<label
						for="subtotal"
						class="block text-sm font-medium leading-6 text-gray-900"
						>Zwischensumme</label
					>
					<div class="relative mt-2 rounded-md shadow-sm">
						<div
							class="pointer-events-none absolute inset-y-0 left-0 flex items-center pl-3"
						>
							<span class="text-gray-500 sm:text-sm">€</span>
						</div>
						<input
							v-model="order.data.subtotal"
							type="text"
							name="subtotal"
							id="subtotal"
							class="block w-full rounded-md border-0 py-1.5 pl-7 pr-20 text-gray-900 ring-1 ring-inset ring-gray-300 placeholder:text-gray-400 focus:ring-2 focus:ring-inset focus:ring-indigo-600 sm:text-sm sm:leading-6"
							placeholder="0.00"
						/>
					</div>
				</div>
				<div class="">
					<label
						for="VAT"
						class="block text-sm font-medium leading-6 text-gray-900"
						>MwSt.</label
					>
					<div class="relative mt-2 rounded-md shadow-sm">
						<input
							v-model="order.data.VAT"
							type="text"
							name="VAT"
							id="VAT"
							class="tabular-nums block w-full rounded-md border-0 py-1.5 pl-7 pr-20 text-gray-900 ring-1 ring-inset ring-gray-300 placeholder:text-gray-400 focus:ring-2 focus:ring-inset focus:ring-indigo-600 sm:text-sm sm:leading-6"
							placeholder="0"
							inputmode="numeric"
							pattern="\d*"
						/>
						<div
							class="absolute inset-y-0 right-2 flex items-center text-sm text-gray-700"
						>
							EUR
						</div>
					</div>
				</div>
			</div>

			<div class="flex flex-col gap-2 w-1/6">
				<div class="">
					<label
						for="payment"
						class="block text-sm font-medium leading-6 text-gray-900"
						>Zahlungsart</label
					>
					<div class="relative mt-2 rounded-md shadow-sm">
						<div
							class="block w-full rounded-md border-0 text-gray-900 ring-1 ring-inset ring-gray-300 sm:text-sm sm:leading-6"
						>
							<select
								v-model="order.data.payment"
								id="delivery"
								name="delivery"
								class="h-full w-full py-2.5 pl-2 py-2 rounded-md border-0 bg-transparent text-gray-500 focus:ring-2 focus:ring-inset focus:ring-indigo-600 sm:text-sm"
							>
								<option disabled :selected="!order.data.payment">
									Bitte eine Zahlungsart wählen
								</option>
								<option
									v-for="(option, i) in paymentOptions"
									:value="option.id"
									:key="i"
									:selected="option.id === order.data.payment"
								>
									{{ option.name }} (+ {{ option.price.toFixed(2) }} €)
								</option>
							</select>
						</div>
					</div>
				</div>
				<div class="">
					<label
						for="delivery"
						class="block text-smtext-sm font-medium leading-6 text-gray-900"
						>Versandart</label
					>
					<div class="relative mt-2 rounded-md shadow-sm">
						<div
							class="block w-full rounded-md border-0 text-gray-900 ring-1 ring-inset ring-gray-300 sm:text-sm sm:leading-6"
						>
							<select
								v-model="order.data.delivery"
								id="delivery"
								name="delivery"
								class="h-full w-full py-2.5 pl-2 py-2 rounded-md border-0 bg-transparent text-gray-500 focus:ring-2 focus:ring-inset focus:ring-indigo-600 sm:text-sm"
							>
								<option disabled :selected="!order.data.delivery">
									Zahlungsart wählen
								</option>
								<option
									v-for="(option, i) in deliveryOptions"
									:value="option.id"
									:key="i"
									:selected="option.id === order.data.delivery"
								>
									{{ option.name }} (+ {{ option.price.toFixed(2) }} €)
								</option>
							</select>
						</div>
					</div>
				</div>
			</div>

			<div class="flex gap-2 w-2/3">
				<div
					v-if="order.products"
					class="w-1/2 flex flex-col gap-6 rounded-md bg-stone-100 p-4"
				>
					<h2 class="block text-sm font-medium leading-6 text-gray-900">
						Produktübersicht
					</h2>
					<article
						v-for="(product, i) in order.products"
						:key="i"
						class="flex space-x-2"
					>
						<div class="text-sm truncate">
							{{ product.attributes.name }}
						</div>
						<div class="text-sm">
							<span class="bg-white p-2 rounded-md whitespace-nowrap"
								>{{
									product.attributes.cover.data.attributes.price.toFixed(
										2
									)
								}}
								€</span
							>
						</div>
					</article>
				</div>
				<div class="w-1/4 flex flex-col gap-2">
					<button
						@click="() => generateInvoicePdf()"
						:class="[
							isGeneratingInvoice
								? `text-gray-500 cursor-progress`
								: `text-white`
						]"
						:disabled="isGeneratingInvoice"
						class="h-16 w-full px-3 py-2 text-left bg-orange-700 font-semibold drop-shadow-md rounded-md"
					>
						Rechnung erstellen
					</button>
					<div v-if="order.invoice">
						<div>
							<a
								:href="`http://localhost:5555${order.invoice.url}`"
								class="flex flex-row items-center space-between text-sm h-16 w-full px-3 py-2 bg-orange-200 rounded-md focus:ring-2 focus:ring-inset focus:ring-indigo-600"
								target="_blank"
							>
								Rechnung herunterladen
								<span class="text-xs text-right">{{
									order.invoice.createdAt
								}}</span>
							</a>
						</div>
					</div>
					<div v-if="isGeneratingInvoice">
						<div
							class="flex flex-row items-center space-between text-sm h-16 w-full px-3 py-2 bg-gray-200 rounded-md focus:ring-2 focus:ring-inset focus:ring-indigo-600"
						>
							Rechnung wird geladen...
						</div>
					</div>
					<div>
						<label
							for="invoiceAddress"
							class="block text-sm font-medium leading-6 text-gray-900"
							>Rechnungsadresse</label
						>
						<textarea
							v-model="order.data.invoiceAddress"
							id="invoiceAddress"
							name="invoiceAddress"
							class="w-full h-20 rounded-md border-0 py-1.5 px-2 pr-20 text-gray-900 ring-1 ring-inset ring-gray-300 placeholder:text-gray-400 focus:ring-2 focus:ring-inset focus:ring-indigo-600 sm:text-sm sm:leading-6"
						></textarea>
					</div>
					<div>
						<label
							for="nr-invoice"
							class="block text-sm font-medium leading-6 text-gray-900"
							>Rechnungsnr.</label
						>
						<div class="relative mt-2 rounded-md shadow-sm">
							<input
								v-model="order.nr.invoice"
								type="text"
								name="nr-invoice"
								id="nr-invoice"
								class="block w-full rounded-md border-0 py-1.5 px-2 text-gray-900 ring-1 ring-inset ring-gray-300 placeholder:text-gray-400 focus:ring-2 focus:ring-inset focus:ring-indigo-600 sm:text-sm sm:leading-6"
								disabled
							/>
						</div>
					</div>
					<div>
						<label
							for="date"
							class="block text-sm font-medium leading-6 text-gray-900"
							>Rechnungsdatum</label
						>
						<div class="relative mt-2 rounded-md shadow-sm">
							<input
								v-model="order.data.Date"
								type="date"
								name="date"
								id="date"
								class="block w-full rounded-md border-0 py-1.5 px-2 text-gray-900 ring-1 ring-inset ring-gray-300 placeholder:text-gray-400 focus:ring-2 focus:ring-inset focus:ring-indigo-600 sm:text-sm sm:leading-6"
							/>
						</div>
					</div>
				</div>

				<div class="w-1/4 flex flex-col gap-2">
					<button
						@click="() => generateDeliveryNote()"
						:class="[
							isGeneratingDeliveryNote
								? `text-gray-500 cursor-progress`
								: `text-white`
						]"
						:disabled="isGeneratingDeliveryNote"
						class="h-16 w-full px-3 py-2 text-left bg-gray-900 font-semibold drop-shadow-md rounded-md"
					>
						Lieferschein erstellen
					</button>
					<div v-if="order.deliveryNote">
						<div>
							<a
								:href="`http://localhost:5555${order.deliveryNote.url}`"
								class="flex flex-row items-center space-between text-sm h-16 w-full px-3 py-2 bg-gray-200 rounded-md focus:ring-2 focus:ring-inset focus:ring-indigo-600"
								target="_blank"
							>
								Lieferschein herunterladen
								<span class="text-xs text-right">{{
									order.deliveryNote.createdAt
								}}</span>
							</a>
						</div>
					</div>
					<div v-if="isGeneratingDeliveryNote">
						<div
							class="flex flex-row items-center space-between text-sm h-16 w-full px-3 py-2 bg-gray-200 rounded-md focus:ring-2 focus:ring-inset focus:ring-indigo-600"
						>
							Lieferschein wird geladen...
						</div>
					</div>
					<div>
						<label
							for="address"
							class="block text-sm font-medium leading-6 text-gray-900"
							>Lieferadresse</label
						>
						<textarea
							v-model="order.data.address"
							id="address"
							name="address"
							class="w-full h-20 rounded-md border-0 py-1.5 px-2 pr-20 text-gray-900 ring-1 ring-inset ring-gray-300 placeholder:text-gray-400 focus:ring-2 focus:ring-inset focus:ring-indigo-600 sm:text-sm sm:leading-6"
						></textarea>
					</div>
					<div>
						<label
							for="nr-deliveryNote"
							class="block text-sm font-medium leading-6 text-gray-900"
							>Lieferscheinnr.</label
						>
						<div class="relative mt-2 rounded-md shadow-sm">
							<input
								v-model="order.nr.shipping"
								type="text"
								name="nr-deliveryNote"
								id="nr-deliveryNote"
								class="block w-full rounded-md border-0 py-1.5 px-2 text-gray-900 ring-1 ring-inset ring-gray-300 placeholder:text-gray-400 focus:ring-2 focus:ring-inset focus:ring-indigo-600 sm:text-sm sm:leading-6"
								disabled
							/>
						</div>
					</div>
				</div>
			</div>

			<!--      <div class="flex gap-2 w-1/2"></div>-->
		</div>
		<div class="flex gap-2 w-1/2"></div>
		<div class="flex gap-2 my-8"></div>
	</section>
	<!--	  <pre class="container mx-auto">{{ JSON.stringify(formData, null, 2) }}</pre>-->
	<section v-if="false" class="container mx-auto bg-slate-100 rounded px-8 py-12">
		<h2 class="leading-3 font-semibold text-size-lg">Rechnung</h2>
		<div class="grid gap-4 grid-cols-4 grid-rows-2">
			<fieldset>
				<label for="date">Datum</label>
				<input v-model="order.data.Date" type="date" id="date" name="date" />
			</fieldset>

			<fieldset>
				<label>Rechnung Nr.</label>
				<input v-model="order.nr.invoice" type="text" disabled />
			</fieldset>

			<fieldset>
				<label for="invoiceAddresss">Rechnungsadresse</label>
				<textarea
					v-model="order.data.invoiceAddress"
					id="invoiceAddress"
					name="invoiceAddress"
					class="w-full h-20 border-0 py-1.5 px-2 pr-20 text-gray-900 ring-1 ring-inset ring-gray-300 placeholder:text-gray-400 focus:ring-2 focus:ring-inset focus:ring-indigo-600 sm:text-sm sm:leading-6"
				></textarea>
			</fieldset>

			<fieldset>
				<label for="payment">Zahlungsart</label>
				<div class="relative">
					<div
						class="block w-full border-0"
					>
						<select
							v-model="order.data.payment"
							id="delivery"
							name="delivery"
							class="h-full w-full py-2.5 py-2 border-0 bg-transparent"
						>
							<option disabled :selected="!order.data.payment">
								Bitte eine Zahlungsart wählen
							</option>
							<option
								v-for="(option, i) in paymentOptions"
								:value="option.id"
								:key="i"
								:selected="option.id === order.data.payment"
							>
								{{ option.name }} (+ {{ option.price.toFixed(2) }} €)
							</option>
						</select>
					</div>
				</div>
			</fieldset>
		</div>
	</section>
</template>
