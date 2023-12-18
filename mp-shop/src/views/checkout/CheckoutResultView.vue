<template>
  <div class="bg-white p-8 shadow-md rounded-md">
    <h1 class="text-2xl font-bold mb-4">Order Summary</h1>

    <div class="flex items-center justify-between mb-4">
      <div class="text-gray-600">Checkout ID:</div>
      <div class="font-bold">{{ uuid }}</div>
    </div>

    <div class="flex items-center justify-between mb-4">
      <div class="text-gray-600">Payment Status:</div>
      <div class="font-bold">{{ order.paymentStatus }}</div>
    </div>

    <h2 class="text-xl font-bold mt-6 mb-4">Ordered Products</h2>

    <div v-if="order && order.cartProducts">
      <div v-for="(position, index) in order.cartProducts" :key="index" class="mb-4">
        <div class="flex items-center justify-between">
          <div class="font-bold">{{ position.product.name }}</div>
          <div class="font-bold">{{ position.product.totalProductPrice.toFixed(2) }} €</div>
        </div>
        <div class="text-gray-600">{{ position.product.pages?.name }}, {{ position.product.ruling?.name }}</div>
        <!-- Add more details if needed -->
      </div>
    </div>

    <div class="mt-6">
      <h2 class="text-xl font-bold mb-4">Order Total</h2>
      <div class="flex items-center justify-between">
        <div class="text-gray-600">Subtotal:</div>
        <div class="font-bold">{{ order.subtotal?.toFixed(2) }} €</div>
      </div>
      <div class="flex items-center justify-between">
        <div class="text-gray-600">VAT:</div>
        <div class="font-bold">{{ order.VAT?.toFixed(2) }} €</div>
      </div>
      <!-- Add more details if needed -->
      <div class="flex items-center justify-between mt-4">
        <div class="text-xl font-bold">Total:</div>
        <div class="text-xl font-bold">{{ order.total?.toFixed(2) }} €</div>
      </div>
    </div>

    <div class="mt-8">
      <h2 class="text-xl font-bold mb-4">Order Details</h2>
      <div class="flex items-center justify-between">
        <div class="text-gray-600">Order Date:</div>
        <div class="font-bold">{{ order.date }}</div>
      </div>
    </div>

    <!-- Download Invoice Button -->
    <div class="mt-8">
      <h2 class="text-xl font-bold mb-4">Download Invoice</h2>
      <button @click="downloadInvoice" class="bg-blue-500 text-white px-4 py-2 rounded-md">
        Download Invoice
      </button>
    </div>
  </div>

  <CodeBlock>{{order}}</CodeBlock>
</template>

<script lang="ts">
import {shopApi} from "@/services/ShopApi";
import debug from "debug";
import CodeBlock from "@/components/CodeBlock.vue";
import type {Order} from "@/types";

const logger = debug("app:i:checkout-result-view");
const verbose = debug("app:v:checkout-result-view");

export default {
  components: {CodeBlock},
	props: ["uuid"],
  data() {
    return {
      order: {} as Order
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
    downloadInvoice() {
      try {
        if (this.order.invoice) {
          window.open(this.order.invoice.attributes.url, "_blank");
        } else {
          logger("Invoice URL not available");
        }
      } catch (e) {
        logger("Error downloading invoice:", e);
      }
    },
  }
}
</script>
