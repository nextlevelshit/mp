import type { BaseListItem } from "@/dto/Common";
import { BaseListDto } from "@/dto/Common";

export class ProductListDto extends BaseListDto<ProductListItem> {
	transformer = (item: ProductListItem): string[] => {
		const publishedSince = item.attributes.publishedAt;

		return [
			item.attributes.name,
			`${item.attributes.price} EUR`,
			item.attributes.description,
			publishedSince ? `seit ${new Date(publishedSince).toDateString()}` : "Offline"
		];
	};
	header = ["Produktname", "Preis", "Beschreibung", "Online"];
	title = "Kundenadressen";
	options = new Map([
		["Alle", { query: "all" }],
		["Online", { query: "" }],
		["Offline", { query: "" }],
		["Ohne Preis", { query: "" }]
	]);
	editLink = (id: number) => `/edit/product/${id}`;

	constructor(list: ProductListItem[]) {
		super(list);
	}
}

export interface ProductListItem extends BaseListItem {
	attributes: {
		description: string;
		name: string;
		price: number;
		updatedAt: string;
		publishedAt: string | null;
	};
}
