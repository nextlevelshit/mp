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
		name: string;
		description: string | null;
		price: number | null;
		createdAt: string;
		updatedAt: string;
		publishedAt: string;
		cover: {
			data: {
				id: number;
				attributes: {
					name: string;
					binding: string;
					price: number;
					createdAt: string;
					updatedAt: string;
					copyText: {
						text: string;
						cover: string;
						paper: string;
						format: string;
						content: string;
						details: string;
						banderole: string;
					};
				};
			};
		};
		pattern: {
			data: {
				id: number;
				attributes: {
					name: string;
					createdAt: string;
					updatedAt: string;
					description: string;
				};
			};
		};
		pages: {
			data: {
				id: number;
				attributes: {
					name: string;
					price: number;
					createdAt: string;
					updatedAt: string;
				};
			};
		};
		ruling: {
			data: {
				id: number;
				attributes: {
					name: string;
					price: number;
					createdAt: string;
					updatedAt: string;
				};
			};
		};
		image: {
			data: {
				id: number;
				attributes: {
					name: string;
					alternativeText: string | null;
					caption: string | null;
					width: number;
					height: number;
					formats: {
						small: {
							ext: string;
							url: string;
							hash: string;
							mime: string;
							name: string;
							path: string | null;
							size: number;
							width: number;
							height: number;
						};
						thumbnail: {
							ext: string;
							url: string;
							hash: string;
							mime: string;
							name: string;
							path: string | null;
							size: number;
							width: number;
							height: number;
						};
					};
					hash: string;
					ext: string;
					mime: string;
					size: number;
					url: string;
					previewUrl: string | null;
					provider: string;
					provider_metadata: string | null;
					createdAt: string;
					updatedAt: string;
				};
			};
		};
	};
}
