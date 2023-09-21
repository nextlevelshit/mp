<script>
import { depotApi } from "@/services/DepotApi";
import debug from "debug";

export default {
	props: ["id"],
	data() {
		return {
			error: null,
			formData: [],
      logger: debug("app:i:order-view")
		};
	},
	mounted() {
		this.logger(`Edit order with Id "${this.id}"`);

		if (this.id) {
			depotApi.orderFactory().one(this.id).then(this.fillForm);
		} else {
      this.logger("Id not provided, creating new order")
		}
	},
	methods: {
		fillForm(data) {
			this.formData = data;
		}
	}
};
</script>

<template>
  <pre class="container mx-auto">{{JSON.stringify({ id, formData }, null, 2)}}</pre>
</template>
