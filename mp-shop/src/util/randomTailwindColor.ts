type TailwindColorPrefix = "text" | "bg" | "shadow";

type TailwindColorShade = 50 | 100 | 150 | 200 | 300 | 400 | 500 | 600 | 700 | 800 | 900;

export const randomTailwindColor = (
	rand: number,
	prefix: TailwindColorPrefix = "bg",
	shade: TailwindColorShade = 200,
	suffix = ""
) => {
	const tailwindColors = [
		// "slate",
		// "gray",
		// "zinc",
		// "neutral",
		// "stone",
		"red",
		"orange",
		"amber",
		"yellow",
		"lime",
		"green",
		"emerald",
		"teal",
		"cyan",
		"sky",
		"blue",
		"indigo",
		"violet",
		"purple",
		"fuchsia",
		"pink",
		"rose"
	];

	const randomColorIndex = rand % tailwindColors.length;

	return `${prefix}-${tailwindColors[randomColorIndex]}-${shade}${suffix}`;
};
