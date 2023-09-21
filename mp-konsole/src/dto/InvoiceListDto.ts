import type { BaseListItem } from "@/dto/Common";
import { BaseListDto } from "@/dto/Common";

export class InvoiceListDto extends BaseListDto<InvoiceListItem> {
	transformer = (item: InvoiceListItem): string[] => [
		item.id,
		item.attributes.Date,
		item.attributes.order.data.attributes.createdAt,
		item.attributes.customer.data.Name,
		item.attributes.customer.data.Address
	];
	header = ["ID", "Rechnungsdatum", "Bestelldatum", "Name", "Adresse"];
	title = "Rechnungen";
	options = new Map([
		["Alle", { query: "all" }],
		["Bezahlt", { query: "" }],
		["Offen", { query: "all " }]
	]);
	createLink = "/create/invoice";
	editLink = (id: number) => `/edit/invoice/${id}`;

	constructor(list: InvoiceListItem[]) {
		super(list);
	}
}

export interface InvoiceListItem extends BaseListItem {
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
