<script>
import { depotApi } from "@/services/DepotApi";
import TableTable from "@/components/TableTable.vue";

export default {
	components: { TableTable },
	props: ["path"],
	data() {
		return {
			error: null,
			list: []
		};
	},
	created() {
		console.log("path created", this.path);

		if (depotApi.routes.has(this.path)) {
			depotApi.all(this.path).then((data) => {
				// this.items = data;
				this.list = depotApi.dto(this.path, data);
				// this.list = new CustomerListDto(data);
			});
		} else {
			console.warn(`Path ${this.path} not included in available routes`);
			this.error = "Cannot find this page. Please, try another one.";
		}
	},
	beforeUpdate() {
		console.log("update with path", this.path);
	}
};
</script>

<template>
	<TableTable :list="list" />
</template>
