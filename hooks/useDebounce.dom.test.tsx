import { describe, it, expect, vi } from "vitest";
import React, { useState } from "react";
import { render, screen } from "@testing-library/react";
import { act } from "react-dom/test-utils";
import useDebounce from "@/hooks/useDebounce";

function DebounceProbe({ value, delay }: { value: string; delay: number }) {
  const debounced = useDebounce(value, delay);
  return <div data-testid="out">{debounced}</div>;
}

describe("useDebounce", () => {
  it("delays value updates until timeout", async () => {
    vi.useFakeTimers();
    function Wrapper() {
      const [value, setValue] = useState("a");
      // expose setter via window for test
      (globalThis as any).__set = setValue;
      return <DebounceProbe value={value} delay={300} />;
    }

    render(<Wrapper />);
    expect(screen.getByTestId("out").textContent).toBe("a");

    act(() => {
      (globalThis as any).__set("ab");
    });
    expect(screen.getByTestId("out").textContent).toBe("a");

    await act(async () => {
      vi.advanceTimersByTime(299);
    });
    expect(screen.getByTestId("out").textContent).toBe("a");

    await act(async () => {
      vi.advanceTimersByTime(1);
    });
    expect(screen.getByTestId("out").textContent).toBe("ab");

    vi.useRealTimers();
  });
});