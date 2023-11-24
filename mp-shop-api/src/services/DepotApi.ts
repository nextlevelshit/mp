import { v4 as generateUuid } from "uuid";
import {depotBearerToken, depotPort} from "../config/constants";
import {Order} from "../util/types";
import {verbose} from "../util/logger";

class DepotApi {
	baseUrl: string;
	headers: Headers;

	constructor(options: DepotApiOptions) {
		this.baseUrl = options.baseUrl;
		this.headers = options.defaultHeaders ?? {};
	}

	private async handleResponse<T>(response: Response): Promise<T | T[]> {
		if (!response.ok) {
			verbose(response.statusText);
			throw new Error(`Request failed with status ${response.status}`);
		}
		const {data} = await response.json();

		return data;
	}

	orderFactory() {
		return {
			create: async (): Promise<Order> => {
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

				return data satisfies Order;
			},

			one: async (uuid: string): Promise<Order> => {
				const response = await fetch(
					`${this.baseUrl}/orders?filters[uuid][$eq]=${uuid}&populate=deep,2`,
					{
						method: "GET",
						headers: this.headers
					}
				);

				const {data} = await response.json();

				return data.pop() satisfies Order;
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

				return updatedOrder;
			}
		};
	}

	async delivery(): Promise<{ id: number; name: string; price: number } | null> {
		const response = await fetch(`${this.baseUrl}/deliveries`, {
			method: "GET",
			headers: this.headers
		});

		if (response.status === 404) {
			return null;
		}

		if (!response.ok) {
			throw new Error(`Request failed with status ${response.status}`);
		}

		const {data} = await response.json();

		return data.map(({id, attributes}) => {
			return {
				id,
				name: attributes.name,
				price: attributes.price
			};
		});
	}

	async payment(): Promise<{ id: number; name: string; price: number } | null> {
		const response = await fetch(`${this.baseUrl}/payments`, {
			method: "GET",
			headers: this.headers
		});

		if (response.status === 404) {
			return null;
		}

		if (!response.ok) {
			throw new Error(`Request failed with status ${response.status}`);
		}

		const {data} = await response.json();

		return data.map(({id, attributes}) => {
			return {
				id,
				name: attributes.name,
				price: attributes.price
			};
		});
	}
}

interface DepotApiOptions {
	baseUrl: string;
	defaultHeaders?: Headers;
}

type Headers = Record<string, string>;

interface Factory<T> {
	create: () => Promise<{ data: T}>;
	one: (uuid: string) => Promise<T>;
	update: (uuid: string, data: any) => Promise<never>;
}

export const depotApi = new DepotApi({
	baseUrl: `http://mp-depot:${depotPort}/api`,
	defaultHeaders: {
		authorization: `Bearer ${depotBearerToken}`,
		"content-type": "application/json"
	}
});
