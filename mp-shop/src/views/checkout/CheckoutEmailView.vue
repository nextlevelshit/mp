<template>
	<div class="container mx-auto">
		<Stepper :step="1"/>

		<main class="mt-8 mb-12 flex flex-col gap-8 max-w-screen-md mx-auto">

			<Title :level="2" html-tag="h1">Wie lauten deine Kontaktinformationen?</Title>

			<div v-if="uuid">
				<!-- Address Form -->
				<form @submit.prevent="submit" class="flex flex-col gap-12">
					<Input label="E-Mail-Address" v-model="emailAddress" :value="emailAddress" :required="true" autocomplete="email"/>

					<label class="flex gap-4 text-sm cursor-pointer">
						<input v-model="acceptedTermsAndConditions" required type="checkbox" class="w-4 cursor-pointer"/>
						<span>
						Mit der Anmeldung bestätige ich, die <a href="/terms" target="_blank" class="underline">AGB</a> und <a href="/privacy" target="_blank" class="underline">Datenschutzerklärung</a> gelesen und verstanden zu haben
						und stimme diesen zu.
					</span>
					</label>

					<hr />

					<Button type="submit" classes="w-full" :is-pending="formSubmitIsPending">Weiter zur Lieferadresse</Button>
				</form>
			</div>
		</main>
	</div>
</template>

<script lang="ts">
import debug from "debug";
import Button from "@/components/Button.vue";
import {shopApi} from "@/services/ShopApi";
import {cart} from "@/stores/cart";
import Stepper from "@/components/Stepper.vue";
import Header from "@/components/Header.vue";
import Input from "@/components/Input.vue";
import Title from "@/components/Title.vue";

const logger = debug("app:i:checkout-email-view");
const verbose = debug("app:v:checkout-email-view");

export default {
	components: {Title, Input, Header, Stepper, Button},
	computed: {
		uuid() {
			return cart.uuid
		}
	},
	data() {
		return {
			emailAddress: "",
			acceptedTermsAndConditions: false,
			formSubmitIsPending: false
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

			try {
				this.formSubmitIsPending = true;

				await shopApi.updateOrder(this.uuid, {
					email: this.emailAddress,
					acceptedTermsAndConditionsAt: new Date().toISOString()
				});

				window.location.assign("/checkout/2");
			} catch (error) {
				logger("Error submitting email address", error);
			} finally {
				this.formSubmitIsPending = false;
			}

		}
	},
	watch: {
		emailAddress: {
			handler(newValue) {
				logger("Email address changed to", newValue);
			}
		}
	}
}
</script>
