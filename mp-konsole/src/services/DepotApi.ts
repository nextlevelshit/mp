import { depotApiBaseUrl, depotApiBearerToken } from "@/config/constants";
import { CustomerListDto } from "@/dto/CustomerListDto";
import type { CustomerListItem } from "@/dto/CustomerListDto";
import { InvoiceListDto } from "@/dto/InvoiceListDto";
import type { InvoiceListItem } from "@/dto/InvoiceListDto";
import { OrderListDto } from "@/dto/OrderListDto";
import type { OrderListItem } from "@/dto/OrderListDto";
import { ProductListDto } from "@/dto/ProductListDto";
import type { ProductListItem } from "@/dto/ProductListDto";

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

	invoiceFactory(): Factory<InvoiceListItem> {
		return {
			create: async (data: InvoiceListItem): Promise<InvoiceListItem> => {
				const response = await fetch(`${this.baseUrl}/invoices?populate=*`, {
					method: "POST",
					headers: this.headers,
					body: JSON.stringify({ data })
				});

				return this.handleResponse<InvoiceListItem>(response);
			},

			one: async (id: string): Promise<InvoiceListItem | null> => {
				const response = await fetch(
					`${this.baseUrl}/invoices/${id}?populate=*`,
					{
						method: "GET",
						headers: this.headers
					}
				);

				if (response.status === 404) {
					return null;
				}

				return this.handleResponse<InvoiceListItem>(response);
			},

			all: async (): Promise<InvoiceListItem[]> => {
				const response = await fetch(`${this.baseUrl}/invoices?populate=*`, {
					method: "GET",
					headers: this.headers
				});

				return this.handleResponse<InvoiceListItem[]>(response);
			}
		};
	}

	customerFactory(): Factory<CustomerListItem> {
		return {
			create: async (): Promise<CustomerListItem> => {
				const response = await fetch(`${this.baseUrl}/customers?populate=*`, {
					method: "POST",
					headers: this.headers
				});

				return this.handleResponse<CustomerListItem>(response);
			},

			one: async (id: string): Promise<CustomerListItem | null> => {
				const response = await fetch(
					`${this.baseUrl}/customers/${id}?populate=*`,
					{
						method: "GET",
						headers: this.headers
					}
				);

				if (response.status === 404) {
					return null;
				}

				return this.handleResponse<CustomerListItem>(response);
			},

			all: async (): Promise<CustomerListItem[]> => {
				const response = await fetch(`${this.baseUrl}/customers?populate=*`, {
					method: "GET",
					headers: this.headers
				});

				return this.handleResponse<CustomerListItem[]>(response);
			}
		};
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
				const response = await fetch(`${this.baseUrl}/orders/${id}?populate=*`, {
					method: "GET",
					headers: this.headers
				});

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

	productFactory(): Factory<ProductListItem> {
		return {
			create: async (data: ProductListItem): Promise<ProductListItem> => {
				const response = await fetch(`${this.baseUrl}/products?populate=*`, {
					method: "POST",
					headers: this.headers,
					body: JSON.stringify({ data })
				});

				return this.handleResponse<ProductListItem>(response);
			},

			one: async (id: string): Promise<ProductListItem | null> => {
				const response = await fetch(
					`${this.baseUrl}/products/${id}?populate=*`,
					{
						method: "GET",
						headers: this.headers
					}
				);

				if (response.status === 404) {
					return null;
				}

				return this.handleResponse<ProductListItem>(response);
			},

			all: async (): Promise<ProductListItem[]> => {
				const response = await fetch(`${this.baseUrl}/products?populate=*`, {
					method: "GET",
					headers: this.headers
				});

				return this.handleResponse<ProductListItem[]>(response);
			}
		};
	}

	get routes(): Map<
		string,
		{ dto: any; factory: Factory<any> }
	> {
		return new Map([
			[
				"customers",
				{
					dto: CustomerListDto,
					factory: this.customerFactory()
				}
			],
			[
				"invoices",
				{
					dto: InvoiceListDto,
					factory: this.invoiceFactory()
				}
			],
			[
				"orders",
				{
					dto: OrderListDto,
					factory: this.orderFactory()
				}
			],
			[
				"products",
				{
					dto: ProductListDto,
					factory: this.productFactory()
				}
			]
		]);
	}

	dto(
		path: DepotApiRoutes,
		data: CustomerListItem[] & InvoiceListItem[] & OrderListItem[] & ProductListItem[]
	) {
		const route = this.routes.get(path);

		if (!route) return null;

		if (route.dto) {
			return new route.dto(data);
		}

		return null;
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
	update?: (id: string, data: T) => Promise<T | null>
}

export const depotApi = new DepotApi({
	baseUrl: depotApiBaseUrl,
	defaultHeaders: {
		Authorization: `Bearer ${depotApiBearerToken}`
	}
});
