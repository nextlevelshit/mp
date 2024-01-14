import {Product } from "../util/types";
import {ProductPagesDto, ProductPagesDtoData} from "./ProductPagesDto";
import {ProductCoverDto, ProductCoverDtoData} from "./ProductCoverDto";
import {ProductRulingDto, ProductRulingDtoData} from "./ProductRulingDto";
import {MediaDataDto, MediaDataDtoData} from "./MediaDataDto";
import {ProductPatternDto, ProductPatternDtoData} from "./ProductPatternDto";
import debug from "debug";

const logger = debug("app:i:product-dto");
const verbose = debug("app:v:product-dto");


export class ProductDto {
	private readonly product: Product;

	constructor(product: Product) {
		this.product = product;
	}

	get id(): number {
		return this.product.id;
	}

	get name(): string {
		return this.product.attributes.name;
	}

	get description(): string | null {
		return this.product.attributes.description;
	}

	get price(): number | null {
		return this.product.attributes.price;
	}

	get publishedAt(): string {
		return this.product.attributes.publishedAt;
	}

	get slug(): string | null {
		return this.product.attributes.slug;
	}

	get cover(): ProductCoverDto | null {
		const productCoverData = this.product.attributes.cover.data;
		return productCoverData ? new ProductCoverDto(productCoverData) : null;
	}

	get pattern(): ProductPatternDto | null {
		const productPatternData = this.product.attributes.pattern.data;
		return productPatternData ? new ProductPatternDto(productPatternData) : null;
	}

	get pages(): ProductPagesDto | null {
		const productPagesData = this.product.attributes.pages.data;
		return productPagesData ? new ProductPagesDto(productPagesData) : null;
	}

	get ruling(): ProductRulingDto | null {
		const productRulingData = this.product.attributes.ruling.data;
		return productRulingData ? new ProductRulingDto(productRulingData) : null;
	}

	get image(): MediaDataDtoData | null {
		const images = this.product.attributes.images.data?.attributes.images.data;
		return images ? new MediaDataDto(images[0]).dto : null;
	}

	get dto(): ProductDtoData {
		return {
			id: this.id,
			name: this.name,
			description: this.description,
			price: this.price,
			publishedAt: this.publishedAt,
			slug: this.slug,
			cover: this.cover ? this.cover.dto : null,
			pattern: this.pattern ? this.pattern.dto : null,
			pages: this.pages ? this.pages.dto : null,
			ruling: this.ruling ? this.ruling.dto : null,
			image: this.image,
			totalProductPrice: this.totalProductPrice()
		};
	}

	totalProductPrice(): number {
		let totalPrice = 0;

		const cover = this.cover;
		const pattern = this.pattern;
		const pages = this.pages;
		const ruling = this.ruling;

		if (cover) {
			totalPrice += cover.price;
		}

		if (pattern) {
			totalPrice += pattern.price;
		}

		if (pages) {
			totalPrice += pages.price;
		}

		if (ruling) {
			totalPrice += ruling.price;
		}

		return totalPrice;
	}
}

export interface ProductDtoData {
	id: number;
	name: string;
	description: string | null;
	price: number | null;
	publishedAt: string;
	slug: string | null;
	cover: ProductCoverDtoData | null;
	pattern: ProductPatternDtoData | null;
	pages: ProductPagesDtoData | null;
	ruling: ProductRulingDtoData | null;
	image: MediaDataDtoData | null;
	totalProductPrice: number
}
