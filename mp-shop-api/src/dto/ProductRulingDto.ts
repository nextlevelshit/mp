import {ProductRuling} from "../types";
import {MediaDataDto, MediaDataDtoData} from "./MediaDataDto";
import debug from "debug";

const logger = debug("app:i:product-ruling-dto");
const verbose = debug("app:v:product-ruling-dto");

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

	get icon(): MediaDataDto | null {
		const icon = this.productRuling.attributes.icon?.data;
		return icon ? new MediaDataDto(icon) : null;
	}

	get dto(): ProductRulingDtoData {
		return {
			id: this.id,
			name: this.name,
			price: this.price,
			icon: this.icon ? this.icon.dto : null,
		};
	}
}

export interface ProductRulingDtoData {
	id: number;
	name: string;
	price: number;
	icon: MediaDataDtoData | null;
}
