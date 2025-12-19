import coreWebVitals from "eslint-config-next/core-web-vitals";
import eslintPluginPrettierRecommended from "eslint-plugin-prettier/recommended";
import importPlugin from "eslint-plugin-import";
import { plugin as tsPlugin } from "typescript-eslint";

const eslintConfig = [
  ...coreWebVitals,
  eslintPluginPrettierRecommended,
  {
    plugins: {
      import: importPlugin,
      "@typescript-eslint": tsPlugin,
    },
    rules: {
      ...importPlugin.configs.recommended.rules,
      "import/no-named-as-default": "off",
      "import/no-absolute-path": "error",
      "import/no-relative-packages": "error",
      "import/order": "error",
      "@typescript-eslint/no-unused-vars": [
        "error",
        {
          argsIgnorePattern: "^_",
          varsIgnorePattern: "^_",
          caughtErrorsIgnorePattern: "^_",
        },
      ],
    },
  },
  {
    ignores: [
      "**/*.bc.js",
      "**/*.res.mjs",
      "**/*.shim.ts",
      "**/*.gen.tsx",
      "lib/supabase/types.ts",
      ".next/**",
      "out/**",
      "build/**",
    ],
  },
];

export default eslintConfig;
