<template>
	<div class="container mx-auto">
		<Stepper :step="2"/>

		<main class="mt-8 mb-12 flex flex-col gap-8 max-w-screen-md mx-auto">
			<Title html-tag="h1" :level="2">Gib deinen Name und Adresse ein:</Title>

			<form @submit.prevent="submit" v-if="uuid">
				<div class="flex flex-col gap-4 max-w-screen-md">
					<Input label="Vorname" v-model="address.name" :required="true"/>
					<Input label="Nachname" v-model="address.surname" :required="true"/>
					<Input label="Straße und Hausnummer:" v-model="address.street"
						   :required="true"/>
					<div class="flex gap-4">
						<Input label="PLZ" v-model="address.postalCode" :required="true"
							   label-class="w-1/2"/>
						<Input label="Ort" v-model="address.city" :required="true"
							   label-class="w-1/2"/>
					</div>

					<label class="flex items-center gap-2 my-4 cursor-pointer">
						<input type="checkbox" v-model="showOptionalDeliveryAddress"
							   :value="showOptionalDeliveryAddress" />
						<span>Abweichende Lieferadresse</span>
					</label>
				</div>

				<div class="flex flex-col gap-4 max-w-screen-md" v-if="showOptionalDeliveryAddress">
					<Input label="Vorname" v-model="deliveryAddress.name"
						   :required="showOptionalDeliveryAddress"/>
					<Input label="Nachname" v-model="deliveryAddress.surname"
						   :required="showOptionalDeliveryAddress"/>
					<Input label="Straße und Hausnummer:" v-model="deliveryAddress.street"
						   :required="showOptionalDeliveryAddress"/>
					<div class="flex gap-4">
						<Input label="PLZ" v-model="deliveryAddress.postalCode"
							   label-class="w-1/2" :required="showOptionalDeliveryAddress"/>
						<Input label="Ort" v-model="deliveryAddress.city"
							   label-class="w-1/2" :required="showOptionalDeliveryAddress"/>
					</div>
				</div>

				<div class="mt-20">
					<Button classes="w-full" type="submit">
						Weiter zur Zahlung
					</Button>
				</div>

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
import Title from "@/components/Title.vue";
import Button from "@/components/Button.vue";

const logger = debug("app:i:checkout-address-view");
const verbose = debug("app:v:checkout-address-view");

export default {
	components: {Button, Title, Header, Stepper, CodeBlock, Input},
	computed: {
		uuid() {
			return cart.uuid
		}
	},
	data() {
		return {
			address: {
				name: "",
				surname: "",
				street: "",
				postalCode: "",
				city: ""
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

			verbose(JSON.stringify(this.address), invoiceAddress);

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
