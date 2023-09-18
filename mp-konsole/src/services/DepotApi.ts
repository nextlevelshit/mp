import { depotApiBaseUrl, depotApiBearerToken } from "@/config/constants";
import { CustomerListDto } from "@/dto/CustomerListDto";
import type { CustomerListItem } from "@/dto/CustomerListDto";
import type { ListItem } from "@/dto/ListDto";
import { InvoiceListDto } from "@/dto/InvoiceListDto";
import type { InvoiceListItem } from "@/dto/InvoiceListDto";
import { OrderListDto } from "@/dto/OrderListDto";
import type { OrderListItem } from "@/dto/OrderListDto";

class DepotApi {
	baseUrl: string;
	headers: Headers;

	constructor(options: DepotApiOptions) {
		this.baseUrl = options.baseUrl;
		this.headers = options.defaultHeaders ?? {};
	}

	async customers() {
		return fetch(`${this.baseUrl}/customers`, {
			method: "GET",
			headers: this.headers
		})
			.then((response) => {
				if (response.ok) {
					return response.json();
				}
			})
			.then(({ data }) => {
				return data;
			})
			.catch((error) => {
				console.error(error);
			});
	}

	async invoices() {
		return fetch(`${this.baseUrl}/invoices?populate=*`, {
			method: "GET",
			headers: this.headers
		})
			.then((response) => {
				if (response.ok) {
					return response.json();
				}
			})
			.then(({ data }) => {
				return data;
			})
			.catch((error) => {
				console.error(error);
			});
	}

	async orders() {
		return fetch(`${this.baseUrl}/orders?populate=*`, {
			method: "GET",
			headers: this.headers
		})
			.then((response) => {
				if (response.ok) {
					return response.json();
				}
			})
			.then(({ data }) => {
				return data;
			})
			.catch((error) => {
				console.error(error);
			});
	}

	get routes() {
		return new Map([
			[
				"customers",
				{
					dto: CustomerListDto,
					all: this.customers()
				}
			],
			[
				"invoices",
				{
					dto: InvoiceListDto,
					all: this.invoices()
				}
			],
			[
				"orders",
				{
					dto: OrderListDto,
					all: this.orders()
				}
			]
		]);
	}

	all(path: DepotApiRoutes): Promise<ListItem[]> {
		const route = this.routes.get(path);

		if (route) {
			return route.all;
		}

		console.log("could not find path", path);

		return new Promise((resolve) => resolve([]));
	}

	dto(
		path: DepotApiRoutes,
		data: CustomerListItem[] & InvoiceListItem[] & OrderListItem[]
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

export const depotApi = new DepotApi({
	baseUrl: depotApiBaseUrl,
	defaultHeaders: {
		Authorization: `Bearer ${depotApiBearerToken}`
	}
});
