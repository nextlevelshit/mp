<script>
import { depotApi } from "@/services/DepotApi";
import debug from "debug";
import { OrderViewDto } from "@/dto/OrderViewDto";

export default {
	props: ["id"],
	data() {
		return {
			error: null,
			orderData: {},
			order: {},
			isGeneratingInvoice: false,
			isGeneratingDeliveryNote: false,
			isUpdatingForm: false,
			hasChanges: true,
			pdfUrl: null,
			logger: debug("app:i:order-view"),
			defaultInvoiceData: {
				subject: "Invoice Subject",
				date: "01.12.2021",
				nr: {
					invoice: "INV12345",
					customer: "CUST6789",
					order: "ORD9876",
					shipping: "C-0012-23333-1"
				},
				to: {
					name: "Customer Name",
					address: ["123 Main St", "City, Country", "ZIP Code"]
				},
				VAT: {
					rate: 19,
					amount: 100
				},
				shipping: 10,
				currency: "\\euro",
				subtotal: 500,
				total: 610,
				service: [
					{
						description: "Service 1",
						price: {
							per_unit: 12,
							total: 12
						},
						count: 3,
						nr: "12345"
					},
					{
						description: "Service 2",
						price: {
							per_unit: 12,
							total: 12
						},
						count: 1,
						nr: "12345"
					},
					{
						description: "Service 3",
						price: {
							per_unit: 12,
							total: 12
						},
						count: 1,
						nr: "12345"
					}
				],
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
						this.orderData = data;

						this.isUpdatingForm = false;
					}, 711);
				})
				.finally(() => {});
		},
		generateDeliveryNote() {
			this.logger(this.order.raw);

			const data = {
				...this.defaultInvoiceData,
				date: this.order.raw.attributes.Date,
				shipping: this.order.raw.attributes.delivery.data.attributes.price,
				VAT: {
					rate: 19,
					amount: this.order.raw.attributes.VAT
				},
				subtotal: this.order.data.subtotal,
				total: this.order.data.total,
				to: {
					name: "",
					address: this.order.raw.attributes.address.split("\n")
				},
				nr: {
					customer: "XXX-XXX-XXX",
					order: "XXX-XXX-XXX",
					shipping: "XXX-XXX-XXX"
				},
				service: this.order.products.map((product) => ({
					description: product.attributes.name,
					price: {
						per_unit: product.attributes.cover.data.attributes.price,
						total: product.attributes.cover.data.attributes.price
					},
					count: 1,
					nr: "XXXX"
				}))
			};

			this.logger(data);

			this.order.resetDeliveryNote();
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

			const data = this.defaultInvoiceData;

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
	<!--  <pre class="container mx-auto">{{JSON.stringify({deliveryOptions, paymentOptions}, null, 2)}}</pre>-->
	<section v-if="order.data" class="container mx-auto relative">
		<h1 class="font-semibold text-2xl mb-6">
			{{ order.raw.attributes.Date }}
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
		<fieldset class="flex gap-2">
			<div class="w-1/5">
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
					<div class="absolute inset-y-0 right-0 flex items-center">
						<label for="totalCurrency" class="sr-only">Währung</label>
						<select
							id="totalCurrency"
							name="totalCurrency"
							class="h-full rounded-md border-0 bg-transparent py-0 pl-2 pr-7 text-gray-500 focus:ring-2 focus:ring-inset focus:ring-indigo-600 sm:text-sm"
						>
							<option>EUR</option>
						</select>
					</div>
				</div>
			</div>
			<div class="w-1/5">
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
					<div class="absolute inset-y-0 right-0 flex items-center">
						<label for="subtotalCurrency" class="sr-only">Währung</label>
						<select
							id="subtotalCurrency"
							name="subtotalCurrency"
							class="h-full rounded-md border-0 bg-transparent py-0 pl-2 pr-7 text-gray-500 focus:ring-2 focus:ring-inset focus:ring-indigo-600 sm:text-sm"
						>
							<option>EUR</option>
						</select>
					</div>
				</div>
			</div>
			<div class="w-1/5">
				<label for="VAT" class="block text-sm font-medium leading-6 text-gray-900"
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
			<div class="w-1/5">
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
								v-for="option in paymentOptions"
								:value="option.id"
								:selected="option.id === order.data.payment"
							>
								{{ option.name }} (+ {{ option.price }} €)
							</option>
						</select>
					</div>
				</div>
			</div>
			<div class="w-1/5">
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
								v-for="option in deliveryOptions"
								:value="option.id"
								:selected="option.id === order.data.delivery"
							>
								{{ option.name }} (+ {{ option.price }} €)
							</option>
						</select>
					</div>
				</div>
			</div>
		</fieldset>
		<div class="flex gap-2 my-8">
			<div class="w-3/5">
				<section
					v-if="order.products"
					class="flex flex-col gap-6 rounded-md border-gray-200"
				>
					<article v-for="(product, i) in order.products" :key="i" class="flex">
						<div class="">
							<span class="bg-stone-100 p-2 rounded-md mr-2"
								>{{
									product.attributes.cover.data.attributes.price
								}}
								€</span
							>
						</div>
						<div class="">
							{{ product.attributes.name }}
						</div>
					</article>
				</section>
			</div>
			<div class="w-2/5 flex gap-2">
				<div class="w-1/2 flex flex-col gap-2">
					<button
						@click="() => generateInvoicePdf()"
						:class="[
							isGeneratingInvoice
								? `text-gray-500 cursor-progress`
								: `text-white`
						]"
						:disabled="isGeneratingInvoice"
						class="h-16 w-full px-3 py-2 text-left bg-gray-900 font-semibold drop-shadow-md rounded-md"
					>
						Rechnung erstellen
					</button>
					<div v-if="order.invoice">
						<div>
							<a
								:href="`http://localhost:5555${order.invoice.url}`"
								class="flex flex-row items-center space-between text-sm h-16 w-full px-3 py-2 bg-gray-200 rounded-md focus:ring-2 focus:ring-inset focus:ring-indigo-600"
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
				</div>

				<div class="w-1/2 flex flex-col gap-2">
					<button
						@click="() => generateDeliveryNote(orderData)"
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
				</div>
			</div>
		</div>
	</section>
	<!--	  <pre class="container mx-auto">{{ JSON.stringify(formData, null, 2) }}</pre>-->
</template>
