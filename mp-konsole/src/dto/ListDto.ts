export interface ListDto<T> {
	transformer: (item: T) => string[];
	header: string[];
	list: T[];
	title: string;
	options?: Map<string, { query: string }>;

	get rows(): string[][];

	get length(): number;
}

export interface ListItem {
	id: string;
}

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
