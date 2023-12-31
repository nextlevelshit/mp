import { ProductCover } from "../util/types";

export class ProductCoverDto {
	private readonly productCover: ProductCover;

	constructor(productCover: ProductCover) {
		this.productCover = productCover;
	}

	get id(): number {
		return this.productCover.id;
	}

	get name(): string {
		return this.productCover.attributes.name;
	}

	get binding(): string {
		return this.productCover.attributes.binding;
	}

	get price(): number {
		return this.productCover.attributes.price;
	}

	get copyText(): {
		text: string;
		cover: string;
		paper: string;
		format: string;
		content: string;
		details: string;
		banderole: string;
	} {
		return this.productCover.attributes.copyText;
	}

	get dto(): ProductCoverDtoData {
		return {
			id: this.id,
			name: this.name,
			binding: this.binding,
			price: this.price,
			copyText: this.copyText,
		};
	}
}

export interface ProductCoverDtoData {
	id: number;
	name: string;
	binding: string;
	price: number;
	copyText: {
		text: string;
		cover: string;
		paper: string;
		format: string;
		content: string;
		details: string;
		banderole: string;
	};
}
