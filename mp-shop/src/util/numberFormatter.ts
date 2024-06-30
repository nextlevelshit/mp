export const numberFormatter = (num: number, symbol?: string): string => {
	const formatter = new Intl.NumberFormat("de-DE", {
		style: "decimal",
		minimumFractionDigits: 2,
		maximumFractionDigits: 2
	});
	return formatter.format(num) + (symbol ? ` ${symbol}` : "");
};
