import { describe, it, expect, vi, beforeEach } from "vitest";

const { suggestJargonMock } = vi.hoisted(() => ({
  suggestJargonMock: vi.fn(),
}));

vi.mock("@/lib/supabase/repository", () => ({
  DB: { suggestJargon: suggestJargonMock },
}));
vi.mock("@/lib/supabase/server", () => ({
  createClient: vi.fn().mockResolvedValue({}),
}));

import { suggestJargon } from "./suggestJargon";

function fd(entries: Record<string, string | string[]>) {
  const f = new FormData();
  for (const [k, v] of Object.entries(entries)) {
    if (Array.isArray(v)) v.forEach((vv) => f.append(k, vv));
    else f.set(k, v);
  }
  return f;
}

beforeEach(() => {
  suggestJargonMock.mockReset();
});

describe("suggestJargon", () => {
  it("returns error when jargon missing", async () => {
    const res = await suggestJargon({ ok: false, error: "" }, fd({}));
    expect(res).toEqual({ ok: false, error: "용어를 입력해 주세요" });
  });

  it("requires translation when noTranslation is false", async () => {
    const res = await suggestJargon(
      { ok: false, error: "" },
      fd({ jargon: "API", noTranslation: "false" }),
    );
    expect(res).toEqual({
      ok: false,
      error: "번역을 입력하거나 '번역 없이 제안하기'를 선택해 주세요",
    });
  });

  it("builds default comment based on noTranslation flag and translation", async () => {
    suggestJargonMock.mockResolvedValueOnce({ data: { jargon_slug: "api" }, error: null });
    await suggestJargon(
      { ok: false, error: "" },
      fd({ jargon: "API", noTranslation: "true", translation: "" }),
    );
    expect(suggestJargonMock).toHaveBeenCalledWith(
      expect.anything(),
      "API",
      true,
      "",
      "API의 번역이 필요해요.",
      [],
    );

    suggestJargonMock.mockResolvedValueOnce({ data: { jargon_slug: "api" }, error: null });
    await suggestJargon(
      { ok: false, error: "" },
      fd({ jargon: "API", noTranslation: "false", translation: "응용프로그램 인터페이스" }),
    );
    expect(suggestJargonMock).toHaveBeenCalledWith(
      expect.anything(),
      "API",
      false,
      "응용프로그램 인터페이스",
      "응용프로그램 인터페이스를 제안해요.",
      [],
    );
  });

  it("parses categoryIds as numbers and filters invalid ones", async () => {
    suggestJargonMock.mockResolvedValueOnce({ data: { jargon_slug: "api" }, error: null });
    await suggestJargon(
      { ok: false, error: "" },
      fd({ jargon: "API", noTranslation: "true", categoryIds: ["1", "2", "abc"] }),
    );
    const call = suggestJargonMock.mock.calls.at(-1)!;
    expect(call[5]).toEqual([1, 2]);
  });

  it("maps known error codes to user-friendly messages", async () => {
    suggestJargonMock.mockResolvedValueOnce({ data: null, error: { code: "23505", message: "dup" } });
    const dup = await suggestJargon({ ok: false, error: "" }, fd({ jargon: "A", noTranslation: "true" }));
    expect(dup).toEqual({ ok: false, error: "이미 존재하는 용어예요" });

    suggestJargonMock.mockResolvedValueOnce({ data: null, error: { code: "23503", message: "fk" } });
    const fk = await suggestJargon({ ok: false, error: "" }, fd({ jargon: "A", noTranslation: "true" }));
    expect(fk).toEqual({ ok: false, error: "존재하지 않는 분야가 포함되어 있어요" });

    suggestJargonMock.mockResolvedValueOnce({ data: null, error: { code: "28000", message: "auth" } });
    const auth = await suggestJargon({ ok: false, error: "" }, fd({ jargon: "A", noTranslation: "true" }));
    expect(auth).toEqual({ ok: false, error: "로그인이 필요해요" });
  });

  it("returns success with slug on success", async () => {
    suggestJargonMock.mockResolvedValueOnce({ data: { jargon_slug: "api" }, error: null });
    const ok = await suggestJargon(
      { ok: false, error: "" },
      fd({ jargon: "API", noTranslation: "true" }),
    );
    expect(ok).toEqual({ ok: true, error: null, jargonSlug: "api" });
  });
});