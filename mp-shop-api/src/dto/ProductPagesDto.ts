import { ProductPages } from "../types";

export class ProductPagesDto {
	private readonly productPages: ProductPages;

	constructor(productPages: ProductPages) {
		this.productPages = productPages;
	}

	get id(): number {
		return this.productPages.id;
	}

	get name(): string {
		return this.productPages.attributes.name;
	}

	get price(): number {
		return this.productPages.attributes.price;
	}

	get dto(): ProductPagesDtoData {
		return {
			id: this.id,
			name: this.name,
			price: this.price
		};
	}
}

export interface ProductPagesDtoData {
	id: number;
	name: string;
	price: number;
}
