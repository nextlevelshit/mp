<template>
	Checkout for {{uuid}}
</template>

<script>
import debug from "debug";

const logger = debug("app:i:checkout-view");
const verbose = debug("app:v:checkout-view");

let AdyenCheckout;
if (process.client) {
	AdyenCheckout = require("@adyen/adyen-web");
}
export default {
	props: ["uuid"],
	data() {
		return {
			checkoutSessionId: null,
			redirectResult: null
		}
	},
	async mounted() {
		const urlParams = new URLSearchParams(window.location.search);
		this.sessionId = urlParams.get("sessionId");
		this.redirectResult = urlParams.get("redirectResult");

		if (this.checkoutSessionId) {
			await this.finalizeCheckout();
		} else {
			await this.startCheckout();
		}
	},
	methods: {
		async startCheckout() {
			verbose("SessionId not found, initilizing checkout");
		},
		async finalizeCheckout() {
			verbose("SessionId found, finilizing checkout");
		},
	}
}
</script>
