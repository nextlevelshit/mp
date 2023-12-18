<template>
  <header class="text-white bg-stone-800 pb-8 mb-2">
    <div class="container mx-auto">
      <h1 class="py-6 font-semibold">mp-shop</h1>
      <nav class="flex justify-end" v-if="isCheckoutRoute">
        <router-link class="hover:text-gray-300" to="/cart">
          Zurück zum Warenkorb
        </router-link>
      </nav>
      <nav class="flex gap-4" v-else>
        <router-link class="hover:text-gray-300" to="/products">
          Produkte
        </router-link>
        <router-link class="hover:text-gray-300" to="/cart">
          Warenkorb ({{ productsCount }})
        </router-link>
        <router-link class="hover:text-gray-300" to="/checkout">
          Kasse
        </router-link>
      </nav>
    </div>
  </header>
</template>

<script lang="ts">
import {cart} from "@/stores/cart";

export default {
  computed: {
    productsCount() {
      return cart.productsCount
    },
    isCheckoutRoute() {
      return String(this.$route.name).startsWith("checkout-");
    }
  },
}
</script>
