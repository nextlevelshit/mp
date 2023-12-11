<template>
  <div>
    <p>Cart with UUID {{ uuid }}</p>
    <ul v-if="cart?.cartProducts">
      <li v-for="(position, i) in cart.cartProducts" :key="i">
        <div class="flex py-2">
          <a class="font-bold mr-8 cursor-pointer" v-on:click="() => removeFromCart(position.product.id)">[ X ]</a>
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
      let uuid = localStorage.getItem(localStorageLabelCartUuid);

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
    async removeFromCart(productId) {
      verbose(`Removing product with ID ${productId} from cart`);

      try {
        this.cart = await shopApi.removeProductFromCart(this.uuid, productId);
      } catch (error) {
        logger(`Could not remove product ${productId} to cart:`, error);
      }
    }
  }
};
</script>
