/** @type {import('tailwindcss').Config} */
module.exports = {
  content: ["./index.html", "./src/**/*.{res,js,ts,jsx,tsx}"],
  theme: {
    extend: {},
    fontFamily: {
      sans: [
        "Inter",
        "Noto Sans KR",
        "SF Pro Text",
        "-apple-system",
        "BlinkMacSystemFont",
        "Helvetica Neue",
        "Arial",
        "sans-serif",
      ],
      mono: ["SFMono-Regular", "Menlo", "Segoe UI", "Courier", "monospace"],
    },
  },
  plugins: [
    require("@tailwindcss/forms"),
    require("@tailwindcss/typography"),
    require("daisyui"),
  ],
  daisyui: {
    themes: [
      "emerald",
      {
        myForest: {
          ...require("daisyui/src/theming/themes")["forest"],
          "--rounded-btn": "0.5rem",
        },
      },
    ],
    darkTheme: "myForest",
  },
};
