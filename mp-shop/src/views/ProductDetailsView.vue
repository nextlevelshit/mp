<template>
  <div class="bg-white p-8 shadow-md rounded-md" v-if="product">
    <h1 class="text-2xl font-bold mb-4">{{ product.name }} - Product ID: {{ id }}</h1>

    <div class="flex gap-36">
      <div class="w-4/5">

        <!-- Product Description -->
        <div v-if="product.description" class="mb-6">
          <h2 class="text-xl font-bold mb-2">Description</h2>
          <p>{{ product.description }}</p>
        </div>

        <!-- Product Details -->
        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">
          <!-- Product Cover Details -->
          <div>
            <h2 class="text-xl font-bold mb-2">Cover Details</h2>
            <p><span class="font-bold">Name:</span> {{ product.cover?.name }}</p>
            <p><span class="font-bold">Binding:</span> {{ product.cover?.binding }}</p>
            <!-- Add more cover details if needed -->
          </div>

          <!-- Product Pattern Details -->
          <div>
            <h2 class="text-xl font-bold mb-2">Pattern Details</h2>
            <p><span class="font-bold">Name:</span> {{ product.pattern?.name }}</p>
            <p><span class="font-bold">Description:</span> {{ product.pattern?.description }}</p>
            <!-- Add more pattern details if needed -->
          </div>

          <!-- Product Pages and Ruling Details -->
          <div>
            <h2 class="text-xl font-bold mb-2">Pages and Ruling Details</h2>
            <p><span class="font-bold">Pages:</span> {{ product.pages?.name }}</p>
            <p><span class="font-bold">Ruling:</span> {{ product.ruling?.name }}</p>
            <!-- Add more pages and ruling details if needed -->
          </div>
        </div>

        <!-- CopyText Details -->
        <div v-if="product.cover?.copyText" class="mt-8">
          <h2 class="text-xl font-bold mb-2">CopyText Details</h2>
          <div v-html="product.cover.copyText.text"></div>
          <p><span class="font-bold">Cover:</span> {{ product.cover.copyText.cover }}</p>
          <p><span class="font-bold">Paper:</span> {{ product.cover.copyText.paper }}</p>
          <p><span class="font-bold">Format:</span> {{ product.cover.copyText.format }}</p>
          <p><span class="font-bold">Content:</span> {{ product.cover.copyText.content }}</p>
          <p><span class="font-bold">Details:</span> {{ product.cover.copyText.details }}</p>
          <p><span class="font-bold">Banderole:</span> {{ product.cover.copyText.banderole }}</p>
        </div>

        <!-- Product Price -->
        <div class="mt-8">
          <h2 class="text-xl font-bold mb-2">Price</h2>
          <p><span class="font-bold">Total Product Price:</span> {{ product.totalProductPrice?.toFixed(2) }} €</p>
          <!-- Add more pricing details if needed -->
        </div>

      </div>
      <div class="w-1/5 flex-col gap-8">
        <!-- Product Image -->
        <img v-if="product.image" :src="product.image.url" :alt="product.image.name" class="mb-4 rounded-md shadow-md" />

        <!-- Add to Cart Button -->
        <button @click="addToCart"
                :disabled="isAddingToCart"
                :class="{ 'opacity-50': isAddingToCart }"
                class="mt-8 bg-blue-500 text-white px-4 py-2 rounded-md w-full">
          <span v-if="isAddingToCart">Adding...</span>
          <span v-else>Add to Cart</span>
        </button>
      </div>
    </div>

    <CodeBlock class="mt-8">{{ product }}</CodeBlock>
  </div>
</template>




<script lang="ts">
import CodeBlock from "@/components/CodeBlock.vue";
import type {Product} from "@/types";
import {shopApi} from "@/services/ShopApi";
import debug from "debug";
import {cart} from "@/stores/cart";

const logger = debug("mp:i:product-details-view");
const verbose = debug("mp:v:product-details-view");

export default {
  components: {CodeBlock},
	props: ["id"],
  computed: {
    uuid() {
      return cart.uuid;
    }
  },
  data() {
    return {
      product: {} as Product,
      isAddingToCart: false
    }
  },
  async mounted() {
    try {
      this.product = await shopApi.getProductById(this.id);
    } catch (e) {
      logger("Could not fetch product");
      verbose(e);
    }
  },
  methods: {
    async addToCart() {
      verbose(`Adding product with ID ${this.product.id} to cart`);

      try {
        this.isAddingToCart = true;
        await shopApi.addProductToCart(this.uuid, this.product.id);
      } catch (error) {
        logger(`Could not add product ${this.product.id} to cart:`, error);
      } finally {
        this.isAddingToCart = false;
        cart.fetch();
      }
    }
  }
}
</script>
