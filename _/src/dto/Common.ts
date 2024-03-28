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

export interface ListDto<T> {
	header: string[];
	list: T[];
	title: string;
	options?: Map<string, { query: string }>;
	createLink?: string;
	editLink?: (id: number) => string;
	deleteLink?: (id: number) => string;

	get rows(): string[][];

	get length(): number;

	transformer(item: T): string[];
}
