import { ProductPattern } from "../util/types";

export class ProductPatternDto {
	private readonly productPattern: ProductPattern;

	constructor(productPattern: ProductPattern) {
		this.productPattern = productPattern;
	}

	get id(): number {
		return this.productPattern.id;
	}

	get name(): string {
		return this.productPattern.attributes.name;
	}

	get description(): string {
		return this.productPattern.attributes.description;
	}

	get price(): number {
		return this.productPattern.attributes?.price || 0;
	}

	get dto(): ProductPatternDtoData {
		return {
			id: this.id,
			name: this.name,
			description: this.description,
			price: this.price
		};
	}
}

export interface ProductPatternDtoData {
	id: number;
	name: string;
	description: string;
	price: number;
}
