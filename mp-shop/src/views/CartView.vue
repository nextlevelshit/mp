<template>
  <div>
    <p>Cart with UUID {{ uuid }}</p>
    <ul v-if="cart?.cartProducts">
      <li v-for="(position, i) in cart.cartProducts" :key="i">
        <div class="flex py-2">
          <button class="font-bold mr-8 cursor-pointer" v-on:click="() => removeFromCart(position.product.id, position.count)">[ X ]</button>
          <button class="font-bold mr-8 cursor-pointer" v-on:click="() => removeFromCart(position.product.id)">[ - ]</button>
          <button class="font-bold mr-8 cursor-pointer" v-on:click="() => addToCart(position.product.id)">[ + ]</button>
          <span>{{position.count}} x {{ position.product.name }} ({{ position.product.id }})</span>
        </div>
      </li>
    </ul>
    <CodeBlock>{{ cart }}</CodeBlock>
  </div>
</template>

<script>
import {localStorageLabelCartUuid} from "@/config/constants";
import {shopApi} from "@/services/ShopApi";
import CodeBlock from "@/components/CodeBlock.vue";
import debug from "debug";

const logger = debug("app:i:cart-view");
const verbose = debug("app:v:cart-view");

export default {
  components: {CodeBlock},
  data() {
    return {
      uuid: null,
      cart: null,
    };
  },
  async mounted() {
    try {
      const uuid = localStorage.getItem(localStorageLabelCartUuid);

      const result = await shopApi.getOrCreateOrder(uuid);
      this.uuid = result.uuid;
      this.cart = result;
      localStorage.setItem(localStorageLabelCartUuid, this.uuid);
    } catch (error) {
      console.error("Error fetching or creating cart:", error);
      localStorage.removeItem(localStorageLabelCartUuid);
    }
  },
  methods: {
    async removeFromCart(productId, count = 1) {
      verbose(`Removing ${count} product with ID ${productId} from cart`);

      try {
        this.cart = await shopApi.removeProductFromCart(this.uuid, productId, count);
      } catch (error) {
        logger(`Could not remove product ${productId} from cart:`, error);
      }
    },
    async addToCart(productId, count = 1) {
      verbose(`Adding ${count} product with ID ${productId} to cart`);

      try {
        this.cart = await shopApi.addProductToCart(this.uuid, productId, count);
      } catch (error) {
        logger(`Could not add product ${productId} to cart:`, error);
      }
    }
  }
};
</script>
