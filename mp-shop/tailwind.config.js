/** @type {(Partial<CustomThemeConfig & {extend: Partial<CustomThemeConfig>}> & DefaultTheme) | (undefined & DefaultTheme)} */

const defaultTheme = require("tailwindcss/defaultTheme")

export default {
	content: [
		"./index.html",
		"./src/**/*.{vue,js,ts,jsx,tsx}",
	],
	theme: {
		extend: {
			fontFamily: {
				"sans": ["Helvetica", "Arial", ...defaultTheme.fontFamily.sans],
				"bebas": ["'Bebas Neue'", ...defaultTheme.fontFamily.sans]
			}
		},
	},
	safelist: [
		{
			pattern: /(bg|shadow)-+/,
		},
	],
	plugins: [
		import('@tailwindcss/forms'),
	],
}
