import { describe, it, expect } from "vitest";
import { cn, eulLeul } from "@/lib/utils";

describe("cn", () => {
  it("merges class names and resolves Tailwind conflicts", () => {
    expect(cn("p-2", "p-4")).toBe("p-4");
    expect(cn("text-sm", { hidden: false }, ["mt-2"])) .toBe("text-sm mt-2");
  });
});

describe("eulLeul", () => {
  it("appends 을 when word ends with final consonant (받침)", () => {
    expect(eulLeul("밥")).toBe("밥을");
    expect(eulLeul("값")).toBe("값을");
  });

  it("appends 를 when word ends without final consonant", () => {
    expect(eulLeul("사과")).toBe("사과를");
    expect(eulLeul("의자")).toBe("의자를");
  });

  it("appends 를 for non-Hangul strings", () => {
    expect(eulLeul("ABC")).toBe("ABC를");
  });
});