import {v4 as generateUuid} from "uuid";
import qs from "qs";
import {depotBearerToken, depotPort} from "../config/constants";
import {
	Order,
	Product,
	ProductRuling,
	PaymentMethod,
	DeliveryMethod,
	ProductPattern,
	ProductPages, ProductCover
} from "../util/types";
import {verbose} from "../util/logger";
import {ProductDto} from "../dto/ProductDto";
import {ProductRulingDto} from "../dto/ProductRulingDto";
import {DeliveryMethodDto} from "../dto/DeliveryMethodDto";
import {PaymentMethodDto} from "../dto/PaymentMethodDto";
import {ProductPatternDto} from "../dto/ProductPatternDto";
import {ProductPagesDto} from "../dto/ProductPagesDto";
import {ProductCoverDto} from "../dto/ProductCoverDto";

class DepotApi {
	baseUrl: string;
	headers: Headers;

	constructor(options: DepotApiOptions) {
		this.baseUrl = options.baseUrl;
		this.headers = options.defaultHeaders ?? {};
	}

	private async fetchEntity<T>(
		endpoint: string,
		mapDto: (item: T) => any,
		filter?: any
	): Promise<any[]> {
		const query = filter ? qs.stringify(filter, { encode: false }) : "";

		verbose(`Querying ${endpoint} with "${query}"`);

		const response = await fetch(`${this.baseUrl}/${endpoint}?${query}&populate=deep,2`, {
			method: "GET",
			headers: this.headers,
		});

		if (!response.ok) {
			throw new Error(`Request failed with status ${response.status}`);
		}

		const { data } = await response.json();
		return (data as T[]).map((item) => mapDto(item).dto);
	}

	orderFactory() {
		return {
			create: async () => {
				const uuid = generateUuid();

				verbose(`Creating cart with UUID ${uuid}`);

				const response = await fetch(`${this.baseUrl}/orders?populate=uuid`, {
					method: "POST",
					headers: this.headers,
					body: JSON.stringify({
						data: {
							uuid
						}
					})
				});

				const {data} = await response.json();

				return data as Order;
			},

			one: async (uuid: string) => {
				const response = await fetch(
					`${this.baseUrl}/orders?filters[uuid][$eq]=${uuid}&populate=deep,2`,
					{
						method: "GET",
						headers: this.headers
					}
				);

				const {data} = await response.json();

				return data.pop() as Order;
			},

			update: async (uuid: string, data: Partial<Order>) => {
				const order = await this.orderFactory().one(uuid);

				const response = await fetch(
					`${this.baseUrl}/orders/${order.id}?populate=deep,3`,
					{
						method: "PUT",
						headers: this.headers,
						body: JSON.stringify({
							data
						})
					}
				);

				const {data: updatedOrder} = await response.json();

				return updatedOrder as Order;
			}
		};
	}

	productFactory() {
		return {
			one: async (id: string) => {
				const response = await fetch(
					`${this.baseUrl}/products/${id}?populate=deep,2`,
					{
						method: "GET",
						headers: this.headers
					}
				);

				const {data} = await response.json();

				return new ProductDto(data).dto;
			},
			all: async (filter?: any) => {
				return this.fetchEntity<Product>(
					"products",
					(product) => new ProductDto(product),
					filter
				);
			},
		}
	}

	async productRuling(filter?: any) {
		return this.fetchEntity<ProductRuling>(
			"product-rulings",
			(productRuling) => new ProductRulingDto(productRuling),
			filter
		);
	}

	async productPattern() {
		return this.fetchEntity<ProductPattern>(
			"product-patterns",
			(pattern) => new ProductPatternDto(pattern)
		);
	}

	async productPages() {
		return this.fetchEntity<ProductPages>(
			"product-pages",
			(pages) => new ProductPagesDto(pages)
		);
	}

	async productCover() {
		return this.fetchEntity<ProductCover>(
			"product-covers",
			(cover) => new ProductCoverDto(cover)
		);
	}

	async deliveryMethod() {
		return this.fetchEntity<DeliveryMethod>(
			"deliveries",
			(deliveryMethod) => new DeliveryMethodDto(deliveryMethod)
		);
	}

	async paymentMethod() {
		return this.fetchEntity<PaymentMethod>(
			"payments",
			(paymentMethod) => new PaymentMethodDto(paymentMethod)
		);
	}
}

interface DepotApiOptions {
	baseUrl: string;
	defaultHeaders?: Headers;
}

type Headers = Record<string, string>;

export const depotApi = new DepotApi({
	baseUrl: `http://mp-depot:${depotPort}/api`,
	defaultHeaders: {
		authorization: `Bearer ${depotBearerToken}`,
		"content-type": "application/json"
	}
});
