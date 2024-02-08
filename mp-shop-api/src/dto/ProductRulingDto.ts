import { ProductRuling } from "../types";

export class ProductRulingDto {
	private readonly productRuling: ProductRuling;

	constructor(productRuling: ProductRuling) {
		this.productRuling = productRuling;
	}

	get id(): number {
		return this.productRuling.id;
	}

	get name(): string {
		return this.productRuling.attributes.name;
	}

	get price(): number {
		return this.productRuling.attributes.price;
	}

	get dto(): ProductRulingDtoData {
		return {
			id: this.id,
			name: this.name,
			price: this.price
		};
	}
}

export interface ProductRulingDtoData {
	id: number;
	name: string;
	price: number;
}
