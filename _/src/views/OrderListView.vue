<script>
import { depotApi } from "@/services/DepotApi";
import TableTable from "@/components/TableTable.vue";
import debug from "debug";
import { OrderListDto } from "@/dto/OrderListDto";

export default {
	components: { TableTable },
	data() {
		return {
			error: null,
			table: null,
			logger: debug("app:i:order-list-view")
		};
	},
	mounted() {
		depotApi
			.orderFactory()
			.all()
			.then((data) => {
				this.table = new OrderListDto(data);
			});
	}
};
</script>

<template>
	<TableTable :table="table" />
</template>
