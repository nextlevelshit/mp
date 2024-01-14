import {CartProduct} from "../util/types";
import {ProductDto, ProductDtoData} from "./ProductDto";
import debug from "debug";

const logger = debug("app:i:cart-product-dto");
const verbose = debug("app:v:cart-product-dto");

export class CartProductDto {
	private readonly cartProduct: CartProduct;
	constructor(cartProduct: CartProduct) {
		this.cartProduct = cartProduct;
	}

	get id(): number {
		return this.cartProduct.id;
	}

	get count(): number {
		return this.cartProduct.count;
	}

	get product(): ProductDto {
		const product = this.cartProduct.product.data;
		return new ProductDto(product);
	}

	get dto(): CartProductDtoData {
		return {
			id: this.id,
			count: this.count,
			product: this.product.dto
		}
	}
}

export interface CartProductDtoData {
	id: number;
	count: number;
	product: ProductDtoData;
}
