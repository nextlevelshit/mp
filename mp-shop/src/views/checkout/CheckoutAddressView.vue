<template>
	<main class="pt-4 container mx-auto">
		<Stepper :step="2"/>

		<div v-if="uuid">
			<h2 class="text-xl mb-4">Checkout - Step 2</h2>

			<form @submit.prevent="submit">
				<label class="block mb-2">
					Address:
					<textarea v-model="address" required class="border p-2 w-full"
							  placeholder="Straße 123&#10;012345 Stadt" rows="3"></textarea>
				</label>

				<label class="block mb-2">
					<input type="checkbox" v-model="showOptionalDeliveryAddress"> Abweichende Lieferadresse
				</label>

				<div v-if="showOptionalDeliveryAddress">
					<label class="block mb-2">
						Delivery Address:
						<textarea v-model="deliveryAddress" class="border p-2 w-full"></textarea>
					</label>
				</div>

				<button type="submit" class="bg-blue-500 text-white px-4 py-2">Submit Address</button>
			</form>
		</div>
		<div v-else>
			Loading cart ...
		</div>

		<CodeBlock>{{ {uuid, address, deliveryAddress} }}</CodeBlock>
	</main>
</template>

<script lang="ts">
import CodeBlock from "@/components/CodeBlock.vue";
import {shopApi} from "@/services/ShopApi";
import debug from "debug";
import {cart} from "@/stores/cart";
import Stepper from "@/components/Stepper.vue";
import Header from "@/components/Header.vue";

const logger = debug("app:i:checkout-email-view");
const verbose = debug("app:v:checkout-email-view");

export default {
	components: {Header, Stepper, CodeBlock},
	computed: {
		uuid() {
			return cart.uuid
		}
	},
	data() {
		return {
			address: "Hans Wurst\nStraße 123\n012345 Stadt",
			showOptionalDeliveryAddress: false,
			deliveryAddress: "",
		}
	},
	methods: {
		async submit() {
			if (!this.uuid) {
				logger("Cart not found, cannot submit form");
				return;
			}

			if (!this.address || this.showOptionalDeliveryAddress && !this.deliveryAddress) {
				logger("Address is empty, cannot submit form");
				return;
			}

			await shopApi.updateOrder(this.uuid, {
				invoiceAddress: this.address,
				address: this.showOptionalDeliveryAddress ? this.deliveryAddress : this.address
			});

			window.location.assign("/checkout/3");
		}
	}
}
</script>
