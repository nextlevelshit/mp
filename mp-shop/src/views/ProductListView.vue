<template>
  <h1 class="text-2xl pb-8">Product List</h1>


  <ul>
    <li v-for="(item, i) in list" :key="i">
      <div class="flex py-2">
        <a class="font-bold mr-8 cursor-pointer" v-on:click="() => addToCart(item.id)">Zum Warenkorb hinzufügen</a>
        <a :href="`/details/${item.id}`">{{ item.name }} ({{ item.id }})</a>
      </div>
    </li>
  </ul>

  <CodeBlock>{{ JSON.stringify(list, null, 2) }}</CodeBlock>
</template>
<script>
import debug from "debug";
import {shopApi} from "@/services/ShopApi";
import {localStorageLabelCartUuid} from "@/config/constants";
import CodeBlock from "@/components/CodeBlock.vue";

const logger = debug("app:i:order-list-view");
const verbose = debug("app:v:order-list-view");

export default {
  components: {CodeBlock},
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
      this.cartUuid = result.uuid;
      this.cart = result;
      localStorage.setItem(localStorageLabelCartUuid, this.cartUuid);
    } catch (error) {
      logger("Error fetching or creating cart:", error);
      localStorage.removeItem(localStorageLabelCartUuid);
    }
  },
  methods: {
    async addToCart(productId) {
      verbose(`Adding product with ID ${productId} to cart`);

      try {
        this.cart = await shopApi.addProductToCart(this.cartUuid, productId);
      } catch (error) {
        logger(`Could not add product ${productId} to cart:`, error);
      }
    }
  }
}
</script>
