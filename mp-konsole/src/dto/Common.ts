import type { CustomerListItem } from "@/dto/CustomerListDto";
import type { ProductListItem } from "@/dto/ProductListDto";
import type { OrderListItem } from "@/dto/OrderListDto";
import type { InvoiceListItem } from "@/dto/InvoiceListDto";
import type { ListDto } from "@/dto/ListDto";

export type GenericListItem =
	| CustomerListItem
	| ProductListItem
	| OrderListItem
	| InvoiceListItem;

export class BaseListDto<T> implements ListDto<T> {
	transformer = (item: T): string[] => [item as string];
	header = ["ID"];
	list: T[];
	title = "List";

	constructor(list: T[]) {
		this.list = list;
	}

	get rows(): string[][] {
		return this.list.map(this.transformer);
	}

	get length() {
		return this.list.length;
	}
}

export interface BaseListItem {
	id: string;
}
