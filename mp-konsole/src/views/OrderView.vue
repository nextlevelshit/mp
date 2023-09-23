<script>
import { depotApi } from "@/services/DepotApi";
import debug from "debug";

export default {
	props: ["id"],
	data() {
		return {
			error: null,
			formData: {},
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
			}
		};
	},
	mounted() {
		this.logger(`Edit order with Id "${this.id}"`);

		if (this.id) {
			depotApi.orderFactory().one(this.id).then(this.fillForm);
		} else {
			this.logger("Id not provided, creating new order");
		}
	},
	methods: {
		fillForm(data) {
			this.formData = data;
		},
		generateInvoicePdf(formData) {
			this.logger(formData);
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
				})
				.catch((error) => {
					this.logger(error);
				});
		}
	}
};
</script>

<template>
	<section v-if="formData?.attributes" class="container mx-auto">
		<h1 class="font-semibold text-2xl mb-6">
			{{ formData.attributes.Date }}
			<span class="font-light">(ID: {{ formData.id }})</span>
		</h1>
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
						:value="formData.attributes.total"
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
						:value="formData.attributes.subtotal"
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
						:value="formData.attributes.VAT"
						type="text"
						name="VAT"
						id="VAT"
						class="block w-full rounded-md border-0 py-1.5 pl-7 pr-20 text-gray-900 ring-1 ring-inset ring-gray-300 placeholder:text-gray-400 focus:ring-2 focus:ring-inset focus:ring-indigo-600 sm:text-sm sm:leading-6"
						placeholder="0"
					/>
					<div class="absolute inset-y-0 right-2 flex items-center">%</div>
				</div>
			</div>
			<div class="w-1/5">
				<label
					for="subtotal"
					class="block text-sm font-medium leading-6 text-gray-900"
					>Zahlungsart</label
				>
				<div class="relative mt-2 rounded-md shadow-sm">
					<div
						class="block w-full rounded-md border-0 text-gray-900 ring-1 ring-inset ring-gray-300 sm:text-sm sm:leading-6"
					>
						<select
							id="subtotalCurrency"
							name="subtotalCurrency"
							class="h-full w-full py-2.5 pl-2 py-2 rounded-md border-0 bg-transparent text-gray-500 focus:ring-2 focus:ring-inset focus:ring-indigo-600 sm:text-sm"
						>
							<option>
								{{ formData.attributes.payment.data.attributes.name }}
								(+{{ formData.attributes.payment.data.attributes.price }}
								€)
							</option>
						</select>
					</div>
				</div>
			</div>
			<div class="w-1/5">
				<label
					for="delivery"
					class="block text-sm font-medium leading-6 text-gray-900"
					>Versandart</label
				>
				<div class="relative mt-2 rounded-md shadow-sm">
					<div
						class="block w-full rounded-md border-0 text-gray-900 ring-1 ring-inset ring-gray-300 sm:text-sm sm:leading-6"
					>
						<select
							id="delivery"
							name="delivery"
							class="h-full w-full py-2.5 pl-2 py-2 rounded-md border-0 bg-transparent text-gray-500 focus:ring-2 focus:ring-inset focus:ring-indigo-600 sm:text-sm"
						>
							<option>
								{{ formData.attributes.delivery.data.attributes.name }}
								(+{{ formData.attributes.delivery.data.attributes.price }}
								€)
							</option>
						</select>
					</div>
				</div>
			</div>
		</fieldset>
		<div class="flex gap-2 my-8">
			<div class="w-3/5">
				<section
					v-if="formData?.attributes?.products"
					class="flex flex-col gap-6 rounded-md border-gray-200"
				>
					<article
						v-for="(product, i) in formData.attributes.products.data"
						:key="i"
						class="flex"
					>
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
				<div class="w-1/2">
					<button
						@click="() => generateInvoicePdf(formData)"
						class="h-20 w-full px-12 py-2 bg-gray-900 font-semibold text-white drop-shadow-md rounded-md"
					>
						Rechnung erstellen
					</button>
          <div v-if="formData.attributes.invoice">

          </div>
				</div>
				<button
					class="h-20 w-1/2 px-12 py-2 bg-gray-900 font-semibold text-white drop-shadow-md rounded-md"
				>
					Lieferschein erstellen
				</button>
			</div>
		</div>
	</section>
<!--	<pre class="container mx-auto">{{ JSON.stringify(formData, null, 2) }}</pre>-->
</template>
