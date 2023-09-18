import type { ListItem } from "@/dto/ListDto";
import { BaseListDto } from "@/dto/ListDto";

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

	constructor(list: CustomerListItem[]) {
		super(list);
	}
}

export interface CustomerListItem extends ListItem {
	attributes: {
		Name: string;
		Address: string;
	};
}
