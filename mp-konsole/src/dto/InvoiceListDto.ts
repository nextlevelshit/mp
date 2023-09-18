import type { ListDto, ListItem } from "@/dto/ListDto";

export class InvoiceListDto implements ListDto<InvoiceListItem> {
	transformer = (item: InvoiceListItem): string[] => [
		item.id,
		item.attributes.Date,
		item.attributes.order.data.attributes.createdAt,
		item.attributes.customer.data.Name,
		item.attributes.customer.data.Address
	];
	header = ["ID", "Rechnungsdatum", "Bestelldatum", "Name", "Adresse"];
	list: InvoiceListItem[];
	title = "Rechnungen";
	options = new Map([
		["Alle", { query: "all" }],
		["Bezahlt", { query: "" }],
		["Offen", { query: "all " }]
	]);

	constructor(list: InvoiceListItem[]) {
		this.list = list;
	}

	get rows(): string[][] {
		return this.list.map(this.transformer);
	}

	get length() {
		return this.list.length;
	}
}

export interface InvoiceListItem extends ListItem {
	attributes: {
		Subject: string;
		Date: string;
		customer: {
			data: {
				Name: string;
				Address: string;
			};
		};
		order: {
			data: {
				attributes: {
					createdAt: string;
				};
			};
		};
	};
}
