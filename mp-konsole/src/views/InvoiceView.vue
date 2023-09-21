<script>
import { depotApi } from "@/services/DepotApi";
import debug from "debug";

export default {
	props: ["id"],
	data() {
		return {
			error: null,
			formData: [],
      logger: debug("app:i:invoice-view")
		};
	},
	mounted() {
    this.logger(`Edit invoice with Id "${this.id}"`);

		if (this.id) {
			depotApi.invoiceFactory().one(this.id).then(this.fillForm);
		} else {
      this.logger("Id not provided, creating new invoice");
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
