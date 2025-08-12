import { describe, it, expect, vi, beforeEach } from "vitest";

const { suggestTranslationMock } = vi.hoisted(() => ({
  suggestTranslationMock: vi.fn(),
}));

vi.mock("@/lib/supabase/repository", () => ({
  DB: { suggestTranslation: suggestTranslationMock },
}));
vi.mock("@/lib/supabase/server", () => ({
  createClient: vi.fn().mockResolvedValue({}),
}));

import { suggestTranslation } from "./suggestTranslation";

function fd(entries: Record<string, string>) {
  const f = new FormData();
  for (const [k, v] of Object.entries(entries)) f.set(k, v);
  return f;
}

beforeEach(() => {
  suggestTranslationMock.mockReset();
});

describe("suggestTranslation", () => {
  it("requires translation", async () => {
    const res = await suggestTranslation({ ok: false, error: "" }, fd({}));
    expect(res).toEqual({ ok: false, error: "번역을 입력해 주세요" });
  });

  it("requires jargonId", async () => {
    const res = await suggestTranslation(
      { ok: false, error: "" },
      fd({ translation: "테스트" }),
    );
    expect(res).toEqual({ ok: false, error: "잘못된 요청이에요" });
  });

  it("builds default comment using eulLeul and returns success", async () => {
    suggestTranslationMock.mockResolvedValueOnce({ data: { translation_id: "t1" }, error: null });
    const res = await suggestTranslation(
      { ok: false, error: "" },
      fd({ translation: "인터페이스", jargonId: "j1" }),
    );
    expect(suggestTranslationMock).toHaveBeenCalledWith(
      expect.anything(),
      "j1",
      "인터페이스",
      "인터페이스를 제안해요.",
    );
    expect(res).toEqual({ ok: true, error: null, translationId: "t1" });
  });

  it("maps error codes", async () => {
    suggestTranslationMock.mockResolvedValueOnce({ data: null, error: { code: "23505", message: "dup" } });
    const dup = await suggestTranslation(
      { ok: false, error: "" },
      fd({ translation: "A", jargonId: "j1" }),
    );
    expect(dup).toEqual({ ok: false, error: "이미 존재하는 번역이에요" });

    suggestTranslationMock.mockResolvedValueOnce({ data: null, error: { code: "28000", message: "auth" } });
    const auth = await suggestTranslation(
      { ok: false, error: "" },
      fd({ translation: "A", jargonId: "j1" }),
    );
    expect(auth).toEqual({ ok: false, error: "로그인이 필요해요" });
  });
});