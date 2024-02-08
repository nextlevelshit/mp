/** @type {import('tailwindcss').Config} */
export default {
  content: [
    "./index.html",
    "./src/**/*.{vue,js,ts,jsx,tsx}",
  ],
  theme: {
    extend: {},
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
