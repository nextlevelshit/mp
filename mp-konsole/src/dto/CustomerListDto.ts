import type { BaseListItem } from "@/dto/Common";
import { BaseListDto } from "@/dto/Common";

export class CustomerListDto extends BaseListDto<CustomerListItem> {
	transformer = (item: CustomerListItem): string[] => [
		item.attributes.Name,
		item.id,
		item.attributes.Address
	];
	header = ["Name", "ID", "Adresse"];
	title = "Kundenadressen";
	options = new Map([
		["Alle", { query: "all" }],
		["Bestandskunden", { query: "" }],
		["Neue", { query: "all " }]
	]);
	editLink = (id: number) => `/edit/customer/${id}`;

	constructor(list: CustomerListItem[]) {
		super(list);
	}
}

export interface CustomerListItem extends BaseListItem {
	attributes: {
		Name: string;
		Address: string;
	};
}
