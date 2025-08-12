import { defineConfig } from "vitest/config";
import tsconfigPaths from "vite-tsconfig-paths";

export default defineConfig({
  plugins: [tsconfigPaths()],
  test: {
    globals: true,
    environment: "node",
    environmentMatchGlobs: [
      ["**/*.dom.test.ts", "jsdom"],
      ["**/*.dom.test.tsx", "jsdom"],
    ],
    setupFiles: "./test/setup.ts",
    coverage: {
      reporter: ["text", "html"],
    },
  },
});