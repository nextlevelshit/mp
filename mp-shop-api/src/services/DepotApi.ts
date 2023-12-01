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
				const query = filter ? qs.stringify(filter) : "";

				verbose(`Querying products with "${query}"`)

				const response = await fetch(
					`${this.baseUrl}/products?${query}&populate=deep,2`,
					{
						method: "GET",
						headers: this.headers
					}
				);

				if (!response.ok) {
					throw new Error(`Request failed with status ${response.status}`);
				}

				const {data} = await response.json();

				return (data as Product[]).map((product) => new ProductDto(product).dto);
			}
		}
	}

	async productRuling(filter?: any) {
		const query = filter ? qs.stringify(filter, { encode: false }) : "";

		verbose(`Querying product-rulings with "${query}"`)

		const response = await fetch(
			`${this.baseUrl}/product-rulings?${query}&populate=deep,2`,
			{
				method: "GET",
				headers: this.headers
			}
		);

		if (!response.ok) {
			throw new Error(`Request failed with status ${response.status}`);
		}

		const {data} = await response.json();
		return (data as ProductRuling[]).map((productRuling) => new ProductRulingDto(productRuling).dto);
	}

	async productPattern() {
		const response = await fetch(`${this.baseUrl}/product-patterns?populate=deep,2`, {
			method: "GET",
			headers: this.headers
		});

		if (!response.ok) {
			throw new Error(`Request failed with status ${response.status}`);
		}

		const { data } = await response.json();
		return (data as ProductPattern[]).map((pattern) => new ProductPatternDto(pattern).dto);
	}

	async productPages() {
		const response = await fetch(`${this.baseUrl}/product-pages?populate=deep,2`, {
			method: "GET",
			headers: this.headers
		});

		if (!response.ok) {
			throw new Error(`Request failed with status ${response.status}`);
		}

		const { data } = await response.json();
		return (data as ProductPages[]).map((pages) => new ProductPagesDto(pages).dto);
	}

	async productCover() {
		const response = await fetch(`${this.baseUrl}/product-covers?populate=deep,2`, {
			method: "GET",
			headers: this.headers
		});

		if (!response.ok) {
			throw new Error(`Request failed with status ${response.status}`);
		}

		const { data } = await response.json();
		return (data as ProductCover[]).map((cover) => new ProductCoverDto(cover).dto);
	}

	async deliveryMethod() {
		const response = await fetch(`${this.baseUrl}/deliveries`, {
			method: "GET",
			headers: this.headers
		});

		if (!response.ok) {
			throw new Error(`Request failed with status ${response.status}`);
		}

		const {data} = await response.json();

		return (data as DeliveryMethod[]).map(deliveryMethod => new DeliveryMethodDto(deliveryMethod).dto);
	}

	async paymentMethod() {
		const response = await fetch(`${this.baseUrl}/payments`, {
			method: "GET",
			headers: this.headers
		});

		if (!response.ok) {
			throw new Error(`Request failed with status ${response.status}`);
		}

		const {data} = await response.json();

		return (data as PaymentMethod[]).map(paymentMethod => new PaymentMethodDto(paymentMethod).dto);

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
