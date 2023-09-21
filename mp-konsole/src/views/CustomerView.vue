<script>
import { depotApi } from "@/services/DepotApi";
import debug from "debug";

export default {
	props: ["id"],
	data() {
		return {
			error: null,
			formData: [],
      logger: debug("app:i:customer-view")
		};
	},
	mounted() {
		this.logger(`Edit customer with Id "${this.id}`);

		if (this.id) {
			depotApi.customerFactory().one(this.id).then(this.fillForm);
		} else {
      console.log(`Id not provided, creating new customer`);
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
