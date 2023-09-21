<script>
import { depotApi } from "@/services/DepotApi";
import debug from "debug";

export default {
	props: ["id"],
	data() {
		return {
			error: null,
			formData: [],
      logger: debug("app:i:product-view")
		};
	},
	mounted() {
		this.logger(`Edit product with Id "${this.id}"`);

		if (this.id) {
			depotApi.productFactory().one(this.id).then(this.fillForm);
		} else {
      this.logger("not id provided, creating new product")
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
