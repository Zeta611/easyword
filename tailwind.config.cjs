/** @type {import('tailwindcss').Config} */
module.exports = {
  content: [
    "./index.html",
    "./src/**/*.{res,js,ts,jsx,tsx}",
  ],
  theme: {
    extend: {},
    fontFamily: {
      sans: [
        "Inter",
	"Spoqa Han Sans Neo",
        "SF Pro Text",
        "-apple-system",
        "BlinkMacSystemFont",
        "Helvetica Neue",
        "Arial",
        "sans-serif"
      ],
      mono: [
        "Fira Code",
	"Nanum Gothic Coding",
        "SFMono-Regular",
        "Menlo",
        "Segoe UI",
        "Courier",
        "monospace"
      ]
    },
  },
  plugins: [],
}
