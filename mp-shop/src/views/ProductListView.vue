<template>
	Product List

	<pre>{{JSON.stringify(list, null, 2)}}</pre>
</template>
<script>
import debug from "debug";
import {shopApi} from "@/services/ShopApi";

export default {
	data() {
		return {
			list: null,
			logger: debug("app:i:order-list-view")
		}
	},
	mounted() {
		shopApi.getProducts().then((data) => this.list = data)
	}
}
</script>
