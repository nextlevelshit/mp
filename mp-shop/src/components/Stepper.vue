<template>
	<ol class="flex items-center w-full p-3 space-x-2 text-sm font-medium text-center text-gray-500 bg-white border border-gray-200 rounded-lg shadow-sm dark:text-gray-400 sm:text-base dark:bg-gray-800 dark:border-gray-700 sm:p-4 sm:space-x-4 rtl:space-x-reverse">
		<Step :number="1" :active="step === 1" :url="step > 1 ? getCheckoutBaseUrl(1) : ``" text="E-Mail-Addresse"></Step>
		<Step :number="2" :active="step === 2" :url="step > 2 ? getCheckoutBaseUrl(2) : ``" text="Lieferadresse"></Step>
		<Step :number="3" :active="step === 3" url="" text="Bezahlung"></Step>
	</ol>
</template>

<script lang="ts">
import Step from "@/components/Step.vue";

const checkoutBaseUrl = "/checkout";

export default {
	components: { Step },
	props: {
		step: {
			type: Number,
			required: true
		}
	},
	methods: {
		getCheckoutBaseUrl(step: number) {
			return `${checkoutBaseUrl}/${step}`;
		}
	}
};
</script>
