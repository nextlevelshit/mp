<template>
  <div>
    <h1 class="text-2xl pb-8">Product List</h1>

    <div class="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-8">
      <ProductCard v-for="(item, i) in list" :key="i" :product="item" :cartUuid="cartUuid" />
    </div>

    <CodeBlock class="mt-8">{{ JSON.stringify(list, null, 2) }}</CodeBlock>
  </div>
</template>
<script>
import debug from "debug";
import {shopApi} from "@/services/ShopApi";
import {localStorageLabelCartUuid} from "@/config/constants";
import CodeBlock from "@/components/CodeBlock.vue";
import ProductCard from "@/components/ProductCard.vue";

const logger = debug("app:i:product-list-view");
const verbose = debug("app:v:product-list-view");

export default {
  components: {ProductCard, CodeBlock},
  data() {
    return {
      list: null,
      cartUuid: null,
      cart: null
    }
  },
  async mounted() {
    this.list = await shopApi.getProducts();

    try {
      let cartUuid = localStorage.getItem(localStorageLabelCartUuid);

      const result = await shopApi.getOrCreateOrder(cartUuid);
      // TODO: Fix error handling
      this.cartUuid = result.uuid;
      this.cart = result;
      localStorage.setItem(localStorageLabelCartUuid, this.cartUuid);
    } catch (error) {
      logger("Error fetching or creating cart:", error);
      localStorage.removeItem(localStorageLabelCartUuid);
    }
  },
  methods: {
  }
}
</script>
