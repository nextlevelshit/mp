<template>
  <div class="flex justify-between space-x-4 mb-4 h-36">
    <Step :number="1" :active="step === 1" :completed="step > 1" text="Email"></Step>
    <Step :number="2" :active="step === 2" :completed="step > 2" text="Address"></Step>
    <Step :number="3" :active="step === 3" :completed="step > 3" text="Payment"></Step>
  </div>
</template>

<script>
import Step from "@/components/Step.vue";

export default {
  components: {Step},
  props: {
    step: {
      type: Number,
      required: true,
    },
  },
};
</script>
