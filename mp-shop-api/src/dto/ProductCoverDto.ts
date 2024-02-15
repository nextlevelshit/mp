import { ProductCover } from "../types";
import {MediaDataDto, MediaDataDtoData} from "./MediaDataDto";

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

	get icon(): MediaDataDto | null {
		const icon = this.productCover.attributes.icon.data;
		return icon ? new MediaDataDto(icon) : null;
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
			icon: this.icon ? this.icon.dto : null,
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
	icon: MediaDataDtoData | null;
}
