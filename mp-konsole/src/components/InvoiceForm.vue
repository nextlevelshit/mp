<template>
  <div class="w-1/2 mb-8 ml-8 mt-8 p-4 bg-stone-100 rounded-lg drop-shadow-xl overflow-y-auto z-10">
    <h2 class="text-2xl font-semibold mb-4">mp-konsole v1.0.0 - {{ new Date().toDateString() }}</h2>
    <form @submit.prevent="generateJson">
      <!-- Invoice Information -->
      <fieldset class="mb-6 flex flex-row gap-2">
        <!-- Subject -->
        <div class="mb-4 w-2/3">
          <label for="subject" class="block text-gray-700 font-bold">Betreff:</label>
          <input
            type="text"
            id="subject"
            v-model="invoiceData.subject"
            class="w-full p-2 border rounded-lg focus:outline-none focus:border-blue-500"
          />
        </div>

        <!-- Date -->
        <div class="mb-4 w-1/3">
          <label for="date" class="block text-gray-700 font-bold">Datum:</label>
          <input
            type="text"
            id="date"
            v-model="invoiceData.date"
            class="w-full p-2 border rounded-lg focus:outline-none focus:border-blue-500"
          />
        </div>

        <!-- Letterhead -->
        <div class="mb-4 w-1/3 hidden">
          <label for="letterhead" class="block text-gray-700 font-bold">Vorlage:</label>
          <input
            type="text"
            id="letterhead"
            v-model="invoiceData.letterhead"
            class="w-full p-2 border rounded-lg focus:outline-none focus:border-blue-500"
          />
        </div>
      </fieldset>

      <!-- Invoice Numbers -->
      <fieldset class="mb-6 flex flex-row gap-2">
<!--        <legend class="block text-gray-700 font-bold">Invoice Numbers</legend>-->
        <!-- Invoice Number -->
        <div class="mb-4 w-1/4">
          <label for="invoiceNr" class="block text-gray-700 font-bold">Rechnung Nr.:</label>
          <input
            type="text"
            id="invoiceNr"
            v-model="invoiceData.nr.invoice"
            class="w-full p-2 border rounded-lg focus:outline-none focus:border-blue-500"
          />
        </div>

        <!-- Customer Number -->
        <div class="mb-4 w-1/4">
          <label for="customerNr" class="block text-gray-700 font-bold">Kunden Nr.</label>
          <input
            type="text"
            id="customerNr"
            v-model="invoiceData.nr.customer"
            class="w-full p-2 border rounded-lg focus:outline-none focus:border-blue-500"
          />
        </div>

        <!-- Order Number -->
        <div class="mb-4 w-1/4">
          <label for="orderNr" class="block text-gray-700 font-bold">Bestellnr.:</label>
          <input
            type="text"
            id="orderNr"
            v-model="invoiceData.nr.order"
            class="w-full p-2 border rounded-lg focus:outline-none focus:border-blue-500"
          />
        </div>
        <!-- Shipping Number -->
        <div class="mb-4 w-1/4">
          <label for="orderNr" class="block text-gray-700 font-bold">Lieferschein Nr.:</label>
          <input
            type="text"
            id="orderNr"
            v-model="invoiceData.nr.shipping"
            class="w-full p-2 border rounded-lg focus:outline-none focus:border-blue-500"
          />
        </div>
      </fieldset>

      <!-- Customer Information -->
      <fieldset class="mb-6 flex flex-row gap-2">
<!--        <legend class="block text-gray-700 font-bold">Customer Information</legend>-->
        <!-- Customer Name -->
        <div class="mb-4 w-1/2">
          <label for="customerName" class="block text-gray-700 font-bold">Name:</label>
          <input
            type="text"
            id="customerName"
            v-model="invoiceData.to.name"
            class="w-full p-2 border rounded-lg focus:outline-none focus:border-blue-500"
          />
        </div>

        <!-- Customer Address -->
        <div class="mb-4 w-1/2">
          <label for="customerAddress" class="block text-gray-700 font-bold">Rechnungsadresse:</label>
          <textarea
            id="customerAddress"
            v-model="invoiceData.to.address"
            rows="4"
            class="w-full p-2 border rounded-lg focus:outline-none focus:border-blue-500"
          ></textarea>
        </div>
      </fieldset>

      <!-- Body -->
      <div class="mb-4">
        <label for="body" class="block text-gray-700 font-bold">Body:</label>
        <textarea
            id="body"
            v-model="invoiceData.body"
            class="w-full h-36 p-2 border rounded-lg focus:outline-none focus:border-blue-500"
        ></textarea>
      </div>

      <!-- VAT and Shipping -->
      <fieldset class="mb-6 flex flex-row gap-2">
<!--        <legend class="block text-gray-700 font-bold">VAT and Shipping</legend>-->
        <!-- VAT Rate -->
        <div class="mb-4 w-1/5">
          <label for="VATRate" class="block text-gray-700 font-bold">USt. (in %):</label>
          <input
            type="number"
            id="VATRate"
            v-model="invoiceData.VAT.rate"
            class="w-full p-2 border rounded-lg focus:outline-none focus:border-blue-500"
          />
        </div>

        <!-- VAT Amount -->
        <div class="mb-4 w-1/5">
          <label for="VATAmount" class="block text-gray-700 font-bold">USt. (in EUR):</label>
          <input
            type="number"
            id="VATAmount"
            v-model="invoiceData.VAT.amount"
            class="w-full p-2 border rounded-lg focus:outline-none focus:border-blue-500"
          />
        </div>

        <!-- Shipping -->
        <div class="mb-4 w-1/5">
          <label for="shipping" class="block text-gray-700 font-bold">Versand (in EUR):</label>
          <input
            type="number"
            id="shipping"
            v-model="invoiceData.shipping"
            class="w-full p-2 border rounded-lg focus:outline-none focus:border-blue-500"
          />
        </div>
        <!-- Currency -->
        <div class="mb-4 w-1/5 hidden">
          <label for="currency" class="block text-gray-700 font-bold">Currency:</label>
          <input
            type="text"
            id="currency"
            v-model="invoiceData.currency"
            class="w-full p-2 border rounded-lg focus:outline-none focus:border-blue-500"
          />
        </div>

        <!-- Subtotal -->
        <div class="mb-4 w-1/5">
          <label for="subtotal" class="block text-gray-700 font-bold">Subtotal:</label>
          <input
            type="number"
            id="subtotal"
            v-model="invoiceData.subtotal"
            class="w-full p-2 border rounded-lg focus:outline-none focus:border-blue-500"
          />
        </div>

        <!-- Total -->
        <div class="mb-4 w-1/5">
          <label for="total" class="block text-gray-700 font-bold">Gesamt:</label>
          <input
            type="number"
            id="total"
            v-model="invoiceData.total"
            class="w-full p-2 border rounded-lg focus:outline-none focus:border-blue-500"
          />
        </div>
      </fieldset>
      <!-- Generate JSON Button -->
      <button type="submit" class="w-full px-4 py-2 bg-red-500 text-white rounded-lg hover:bg-red-700">PDF erstellen</button>
    </form>
  </div>
  <pre v-if="invoiceData" class="text-white m-8 overflow-x-auto w-1/2">{{ JSON.stringify(invoiceData, null, 2) }}</pre>
</template>

<script>
export default {
				letterhead: "/app/data/templates/RE.pdf",
	data() {
		return {
			invoiceData: {
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
	methods: {
		generateJson() {
			// Emit the JSON data to the parent component
			this.$emit("json-generated", this.invoiceData);
		}
	}
};
</script>