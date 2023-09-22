<script>
import { depotApi } from "@/services/DepotApi";
import TableTable from "@/components/TableTable.vue";
import debug from "debug";

export default {
	components: { TableTable },
	props: ["dto"],
	data() {
		return {
			error: null,
			table: null,
      logger: debug("app:i:list-view")
		};
	},
	mounted() {
		this.logger(`Mounted component with dto "${this.dto}"`);

		if (depotApi.routes.has(this.dto)) {
			const { factory } = depotApi.routes.get(this.dto);

			factory.all().then((data) => {
				this.table = depotApi.dto(this.dto, data);
			});
		} else {
			this.logger(`Path ${this.dto} not included in available routes`);
			this.error = "Cannot find this page. Please, try another one.";
		}
	},
	created() {
		this.logger(`Created component with path "${this.dto}"`);
	}
};
</script>

<template>
	<TableTable :table="table" />
</template>
