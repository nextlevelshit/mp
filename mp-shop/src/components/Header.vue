<template>
  <header class="text-white bg-stone-800 shadow-stone-700 shadow-inner">
    <div class="container mx-auto">
      <div class="flex gap-12 py-6">
        <h1 class="font-semibold">MUELLERPRINTS. Paperwork</h1>
        <div v-if="$route" role="navigation" class="grow">
          <nav class="flex justify-end" v-if="isCheckoutRoute" aria-label="Navigation">
            <router-link class="hover:text-gray-300" to="/cart">
              Zurück zum Warenkorb
            </router-link>
          </nav>
          <nav class="flex justify-between gap-28" v-else aria-label="Navigation">
            <div class="flex gap-8">
              <router-link class="hover:text-gray-300" to="/products">
                Notizbücher
              </router-link>
              <router-link class="hover:text-gray-300" to="/production">
                Herstellung
              </router-link>
            </div>
            <router-link class="hover:text-gray-300" to="/cart">
              Warenkorb ({{ productsCount }})
            </router-link>
            <!--          <router-link class="hover:text-gray-300" to="/checkout">-->
            <!--            Kasse-->
            <!--          </router-link>-->
          </nav>
        </div>
      </div>
    </div>
  </header>
  <div class="bg-neutral-600 text-neutral-400 font-bold py-4 tracking-wide">
    <div class="container mx-auto">
      Hergestellt aus 100% Altpapier – Lokale Produktion in Stuttgart – Handarbeit made in Germany – Unverpackt und vegan – Gratis Versand ab 25,90 €
    </div>
  </div>
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
