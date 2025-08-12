import "@testing-library/jest-dom";

// Suppress React Query error logs in tests
const originalError = console.error;
beforeAll(() => {
  console.error = (...args: unknown[]) => {
    const msg = String(args[0] ?? "");
    if (msg.includes("React 18+ Strict Mode") || msg.includes("ReactQuery")) return;
    originalError(...(args as Parameters<typeof originalError>));
  };
});

afterAll(() => {
  console.error = originalError;
});