<template>
  <div>
    <h1 class="text-2xl font-bold mb-4">Shopping Cart (UUID: {{ uuid }})</h1>

    <div v-if="cartProducts">
      <ul class="divide-y divide-gray-300">
        <li v-for="(position, index) in cartProducts" :key="index" class="py-2 flex items-center justify-between">
          <div class="flex items-center">
            <button class="text-red-600 font-bold mr-2"
                    @click="() => removeFromCart(position.product.id, position.count)">[ X ]
            </button>
            <button class="text-blue-600 font-bold mr-2" @click="() => removeFromCart(position.product.id)">[ - ]
            </button>
            <button class="text-green-600 font-bold mr-2" @click="() => addToCart(position.product.id)">[ + ]</button>
            <span class="font-semibold">{{ position.count }} x {{ position.product.name }}</span>
          </div>
          <span class="font-semibold">{{ position.product.id }}</span>
        </li>
      </ul>

      <div class="mt-8">
        <h2 class="text-xl font-bold mb-4">Order Details</h2>
        <div class="flex justify-between mb-2">
          <span>Total:</span>
          <span class="font-semibold">{{ cart.total }}</span>
        </div>
        <div class="flex justify-between mb-2">
          <span>Subtotal:</span>
          <span class="font-semibold">{{ cart.subtotal }}</span>
        </div>
        <div class="flex justify-between mb-2">
          <span>VAT:</span>
          <span class="font-semibold">{{ cart.VAT }}</span>
        </div>
      </div>
    </div>

    <div v-else>
      <p class="text-gray-600">Your cart is empty.</p>
    </div>

    <CodeBlock class="mt-8">{{ cart }}</CodeBlock>
  </div>
</template>

<script lang="ts">
import {shopApi} from "@/services/ShopApi";
import CodeBlock from "@/components/CodeBlock.vue";
import debug from "debug";
import {cart} from "@/stores/cart";

const logger = debug("app:i:cart-view");
const verbose = debug("app:v:cart-view");

export default {
  components: {CodeBlock},
  computed: {
    cart() {
      return cart
    },
    uuid() {
      return cart.uuid;
    },
    cartProducts() {
      return cart.products;
    }
  },
  methods: {
    async removeFromCart(productId: number, count = 1) {
      verbose(`Removing ${count} product with ID ${productId} from cart`);

      try {
        const cartAfterUpdate = await shopApi.removeProductFromCart(cart.uuid, productId, count);
        cart.overwrite(cartAfterUpdate);
      } catch (error) {
        logger(`Could not remove product ${productId} from cart:`, error);
      }
    },
    async addToCart(productId: number, count = 1) {
      verbose(`Adding ${count} product with ID ${productId} to cart`);

      try {
        const cartAfterUpdate = await shopApi.addProductToCart(cart.uuid, productId, count);
        cart.overwrite(cartAfterUpdate);
      } catch (error) {
        logger(`Could not add product ${productId} to cart:`, error);
      }
    }
  }
};
</script>
