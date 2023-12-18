<template>
  <Stepper :step="1" />

  <div v-if="uuid">
    <h2 class="text-xl mb-4">Checkout - Step 1</h2>

    <!-- Address Form -->
    <form @submit.prevent="submit">
      <label class="block mb-2">
        E-Mail Address:
        <input v-model="emailAddress" required class="border p-2 w-full" placeholder="" />
      </label>

      <label class="block mb-2">
        <input v-model="acceptedTermsAndConditions" required type="checkbox" />
        Mit der Anmeldung bestätige ich, die AGB und Datenschutzerklärung gelesen und verstanden zu haben und stimme diesen zu.
      </label>

      <button type="submit" class="bg-blue-500 text-white px-4 py-2">Gehe zur Rechnungsanschrift</button>
    </form>
  </div>
  <div v-else>
    Loading cart ...
  </div>

  <CodeBlock>{{ {uuid, emailAddress, acceptedTermsAndConditions} }}</CodeBlock>
</template>

<script lang="ts">
import CodeBlock from "@/components/CodeBlock.vue";
import {shopApi} from "@/services/ShopApi";
import debug from "debug";
import {cart} from "@/stores/cart";
import Stepper from "@/components/Stepper.vue";

const logger = debug("app:i:checkout-email-view");
const verbose = debug("app:v:checkout-email-view");

export default {
  components: {Stepper, CodeBlock},
  computed: {
    uuid() {
      return cart.uuid
    }
  },
  data() {
    return {
      emailAddress: "spam@dailysh.it",
      acceptedTermsAndConditions: false
    }
  },
  methods: {
    async submit() {
      if (!this.uuid) {
        logger("Cart not found, cannot submit form");
        return;
      }

      if (!this.acceptedTermsAndConditions) {
        logger("Terms and conditions not accepted, cannot submit form");
        return;
      }

      await shopApi.updateOrder(this.uuid, {
        email: this.emailAddress,
        acceptedTermsAndConditionsAt: new Date().toISOString()
      });

      window.location.assign("/checkout/2");
    }
  }
}
</script>
