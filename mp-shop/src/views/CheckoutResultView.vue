<template>
	<div>Checkout: {{uuid}}</div>
  <div>Result: {{paymentStatus}}</div>

  <CodeBlock>{{order}}</CodeBlock>
</template>

<script>
import {shopApi} from "@/services/ShopApi";
import debug from "debug";
import CodeBlock from "@/components/CodeBlock.vue";

const logger = debug("app:i:checkout-result-view");
const verbose = debug("app:v:checkout-result-view");

export default {
  components: {CodeBlock},
	props: ["uuid"],
  data() {
    return {
      paymentStatus: "",
      order: null
    }
  },
  async mounted() {
    try {
      const order = await shopApi.getOrder(this.uuid);
      this.paymentStatus = order.paymentStatus;
      this.order = order;
    } catch (e) {
      verbose("Could not fetch checkout status");
    }
  }
}
</script>
