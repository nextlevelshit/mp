export const numberFormatter = (num: number): string => {
	const formatter = new Intl.NumberFormat('de-DE', {
		style: "decimal",
		minimumFractionDigits: 2,
		maximumFractionDigits: 2
	});
	return formatter.format(num);
}
