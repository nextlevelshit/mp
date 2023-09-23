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

			one: async (id: string): Promise<OrderListItem | null> => {
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

			all: async (): Promise<OrderListItem[]> => {
				const response = await fetch(`${this.baseUrl}/orders?populate=*`, {
					method: "GET",
					headers: this.headers
				});

				return this.handleResponse<OrderListItem[]>(response);
			}
		};
	}
}

export enum DepotApiRoutes {
	CUSTOMERS = "customers",
	ORDERS = "orders",
	INVOICES = "invoices"
}

interface DepotApiOptions {
	baseUrl: string;
	defaultHeaders?: Headers;
}

type Headers = Record<string, string>;

interface Factory<T> {
	create: (data: never) => Promise<T>;
	one: (id: string) => Promise<T | null>;
	all: () => Promise<T[]>;
	update?: (id: string, data: T) => Promise<T | null>;
}

export const depotApi = new DepotApi({
	baseUrl: depotApiBaseUrl,
	defaultHeaders: {
		Authorization: `Bearer ${depotApiBearerToken}`
	}
});
