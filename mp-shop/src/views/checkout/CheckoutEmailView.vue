<template>
	<div class="container mx-auto">
		<Stepper :step="1"/>

		<main class="mt-8 mb-12 flex flex-col gap-8 max-w-screen-md mx-auto">

			<h2 class="text-2xl font-bold">Wie lauten deine Kontaktinformationen?</h2>

			<div v-if="uuid">
				<!-- Address Form -->
				<form @submit.prevent="submit" class="flex flex-col gap-12">
					<Input label="E-Mail-Address" v-model="emailAddress" :value="emailAddress" :required="true"/>

					<label class="flex gap-4 text-sm cursor-pointer">
						<input v-model="acceptedTermsAndConditions" required type="checkbox"/>
						<span>
						Mit der Anmeldung bestätige ich, die <a href="/terms" target="_blank" class="underline">AGB</a> und <a href="/privacy" target="_blank" class="underline">Datenschutzerklärung</a> gelesen und verstanden zu haben
						und stimme diesen zu.
					</span>
					</label>

					<hr />

					<button type="submit" class="bg-black text-white py-4 shadow-md hover:shadow-sm rounded-full w-full uppercase font-thin tracking-wide px-10">Weiter zur Lieferadresse</button>
				</form>
			</div>
		</main>
	</div>
</template>

<script lang="ts">
import CodeBlock from "@/components/CodeBlock.vue";
import {shopApi} from "@/services/ShopApi";
import debug from "debug";
import {cart} from "@/stores/cart";
import Stepper from "@/components/Stepper.vue";
import Header from "@/components/Header.vue";
import Input from "@/components/Input.vue";

const logger = debug("app:i:checkout-email-view");
const verbose = debug("app:v:checkout-email-view");

export default {
	components: {Input, Header, Stepper, CodeBlock},
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
