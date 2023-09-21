export interface ListDto<T> {
	transformer: (item: T) => string[];
	header: string[];
	list: T[];
	title: string;
	options?: Map<string, { query: string }>;
	createLink?: string;
	editLink?: (id: number) => string;
	deleteLink?: (id: number) => string;

	get rows(): string[][];

	get length(): number;
}
