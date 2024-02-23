import {ProductPattern, UnsafeProduct} from "../types";
import debug from "debug";
import {MediaDataDto, MediaDataDtoData} from "./MediaDataDto";

const logger = debug("app:i:product-pattern-dto");
const verbose = debug("app:v:product-pattern-dto");

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

	get products(): UnsafeProduct[] | null {
		return null;
		// const products = this.productPattern.attributes.products.data;
		// return products ? products.map<UnsafeProduct>(product => ({
		// 	id: product.id,
		// 	name: product.attributes.name
		// })) : null;
	}

	get image(): MediaDataDtoData | null {
		const image = this.productPattern.attributes.image?.data;
		return image ? new MediaDataDto(image).dto : null;
	}

	get dto(): ProductPatternDtoData {
		return {
			id: this.id,
			name: this.name,
			description: this.description,
			price: this.price,
			products: this.products,
			image: this.image
		};
	}
}

export interface ProductPatternDtoData {
	id: number;
	name: string;
	description: string;
	price: number;
	products: null | UnsafeProduct[];
	image: null | MediaDataDtoData;
}
