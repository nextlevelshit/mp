import { depotApiBaseUrl, depotApiBearerToken } from "@/config/constants";
import { OrderListDto } from "@/dto/OrderListDto";
import type { OrderListItem } from "@/dto/OrderListDto";

class DepotApi {
	baseUrl: string;
	headers: Headers;

	constructor(options: DepotApiOptions) {
		this.baseUrl = options.baseUrl;
		this.headers = options.defaultHeaders ?? {};
	}

	private async handleResponse<T>(response: Response): Promise<T> {
		if (!response.ok) {
			throw new Error(`Request failed with status ${response.status}`);
		}
		const { data } = await response.json();
		return data;
	}

	orderFactory(): Factory<OrderListItem> {
		return {
			create: async (): Promise<OrderListItem> => {
				const response = await fetch(`${this.baseUrl}/orders?populate=*`, {
					method: "POST",
					headers: this.headers
				});

				return this.handleResponse<OrderListItem>(response);
			},

			one: async (id: number): Promise<OrderListItem | null> => {
				const response = await fetch(
					`${this.baseUrl}/orders/${id}?populate=deep,3`,
					{
						method: "GET",
						headers: this.headers
					}
				);

				if (response.status === 404) {
					return null;
				}

				return this.handleResponse<OrderListItem>(response);
			},

			update: async (id, body): Promise<OrderListItem | null> => {
				const response = await fetch(
					`${this.baseUrl}/orders/${id}?populate=deep,3`,
					{
						method: "PUT",
						headers: this.headers,
						body
					}
				);

				if (response.status === 404) {
					return null;
				}

				return this.handleResponse<OrderListItem>(response);
			},

			all: async (): Promise<OrderListItem[]> => {
				const response = await fetch(`${this.baseUrl}/orders?populate=*`, {
					method: "GET",
					headers: this.headers
				});

				return this.handleResponse<OrderListItem[]>(response);
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

		const { data } = await response.json();

		return data.map(({ id, attributes }) => {
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

		const { data } = await response.json();

		return data.map(({ id, attributes }) => {
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
	create: (data: never) => Promise<T>;
	one: (id: number) => Promise<T | null>;
	all: () => Promise<T[]>;
	update?: (id: number, data: any) => Promise<T | null>;
}

export const depotApi = new DepotApi({
	baseUrl: depotApiBaseUrl,
	defaultHeaders: {
		Authorization: `Bearer ${depotApiBearerToken}`
	}
});
