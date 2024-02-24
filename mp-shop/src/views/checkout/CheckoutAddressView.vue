<template>
	<div class="container mx-auto">
		<Stepper :step="2"/>

		<main class="mt-8 mb-12 flex flex-col gap-8 max-w-screen-md mx-auto">
			<h2 class="text-2xl font-bold mb-4">Gib deinen Name und Adresse ein:</h2>

			<form @submit.prevent="submit" v-if="uuid">
				<div class="flex flex-col gap-4 max-w-screen-md">
					<Input label="Vorname" v-model="address.name" :value="address.name" :required="true"/>
					<Input label="Nachname" v-model="address.surname" :value="address.surname" :required="true"/>
					<Input label="Straßeund Hausnummer:" v-model="address.street" :value="address.street"
						   :required="true"/>
					<div class="flex gap-4">
						<Input label="PLZ" v-model="address.postalCode" :value="address.postalCode" :required="true"
							   label-class="w-1/2"/>
						<Input label="Ort" v-model="address.city" :value="address.city" :required="true"
							   label-class="w-1/2"/>
					</div>

					<label class="flex items-center gap-2 my-4 cursor-pointer">
						<input type="checkbox" v-model="showOptionalDeliveryAddress"
							   :value="showOptionalDeliveryAddress" class="form-checkbox"/>
						<span>Abweichende Lieferadresse</span>
					</label>
				</div>

				<div class="flex flex-col gap-4 max-w-screen-md" v-if="showOptionalDeliveryAddress">
					<Input label="Vorname" v-model="deliveryAddress.name" :value="deliveryAddress.name"
						   :required="showOptionalDeliveryAddress"/>
					<Input label="Nachname" v-model="deliveryAddress.surname" :value="deliveryAddress.surname"
						   :required="showOptionalDeliveryAddress"/>
					<Input label="Straßeund Hausnummer:" v-model="deliveryAddress.street"
						   :value="deliveryAddress.street" :required="showOptionalDeliveryAddress"/>
					<div class="flex gap-4">
						<Input label="PLZ" v-model="deliveryAddress.postalCode" :value="deliveryAddress.postalCode"
							   label-class="w-1/2" :required="showOptionalDeliveryAddress"/>
						<Input label="Ort" v-model="deliveryAddress.city" :value="deliveryAddress.city"
							   label-class="w-1/2" :required="showOptionalDeliveryAddress"/>
					</div>
				</div>

				<button type="submit"
						class="mt-20 bg-black text-white py-4 shadow-md hover:shadow-sm rounded-full w-full uppercase font-thin tracking-wide px-10">
					Weiter zur Zahlung
				</button>
			</form>
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
import type {Address} from "@/types";

const logger = debug("app:i:checkout-address-view");
const verbose = debug("app:v:checkout-address-view");

export default {
	components: {Header, Stepper, CodeBlock, Input},
	computed: {
		uuid() {
			return cart.uuid
		}
	},
	data() {
		return {
			address: {
				name: "Hans",
				surname: "Wurst",
				street: "Straße 123",
				postalCode: "012345",
				city: "Stadt"
			} as Address,
			showOptionalDeliveryAddress: false,
			deliveryAddress: {
				name: "",
				surname: "",
				street: "",
				postalCode: "",
				city: ""
			} as Address
		}
	},
	methods: {
		async submit() {
			if (!this.uuid) {
				logger("Warenkorb nicht gefunden, kann das Formular nicht absenden");
				return;
			}

			const invoiceAddress = this.addressToString(this.address);
			const address = this.showOptionalDeliveryAddress ? this.addressToString(this.deliveryAddress) : invoiceAddress;

			await shopApi.updateOrder(this.uuid, {
				invoiceAddress,
				address
			});

			window.location.assign("/checkout/3");
		},
		addressToString(address: Address) {
			return `${address.name} ${address.surname}\n${address.street}\n${address.postalCode} ${address.city}`;
		}
	}
}
</script>
