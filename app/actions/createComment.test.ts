import { describe, it, expect, vi, beforeEach } from "vitest";

const { createCommentDbMock, getUserMock } = vi.hoisted(() => ({
  createCommentDbMock: vi.fn(),
  getUserMock: vi.fn(),
}));

vi.mock("@/lib/supabase/repository", () => ({
  DB: { createComment: createCommentDbMock },
}));
vi.mock("@/lib/supabase/server", () => ({
  createClient: vi.fn().mockResolvedValue({
    auth: { getUser: getUserMock },
  }),
}));

import { createComment } from "./createComment";

function fd(entries: Record<string, string>) {
  const f = new FormData();
  for (const [k, v] of Object.entries(entries)) f.set(k, v);
  return f;
}

beforeEach(() => {
  createCommentDbMock.mockReset();
  getUserMock.mockReset();
});

describe("createComment", () => {
  it("validates content exists", async () => {
    const res = await createComment("j1", null, { ok: false, error: "" }, fd({}));
    expect(res).toEqual({ ok: false, error: "내용을 입력해주세요" });
  });

  it("requires logged-in user", async () => {
    getUserMock.mockResolvedValueOnce({ data: { user: null }, error: null });
    const res = await createComment("j1", null, { ok: false, error: "" }, fd({ content: "hi" }));
    expect(res).toEqual({ ok: false, error: "로그인이 필요해요" });
  });

  it("returns error when DB layer errors", async () => {
    getUserMock.mockResolvedValueOnce({ data: { user: { id: "u1" } }, error: null });
    createCommentDbMock.mockResolvedValueOnce({ error: new Error("db") });
    const res = await createComment("j1", null, { ok: false, error: "" }, fd({ content: "hi" }));
    expect(createCommentDbMock).toHaveBeenCalledWith(expect.anything(), "j1", null, "hi");
    expect(res).toEqual({ ok: false, error: "댓글 다는 중 문제가 생겼어요" });
  });

  it("succeeds when DB layer ok", async () => {
    getUserMock.mockResolvedValueOnce({ data: { user: { id: "u1" } }, error: null });
    createCommentDbMock.mockResolvedValueOnce({ error: null });
    const res = await createComment("j1", "p1", { ok: false, error: "" }, fd({ content: "hello" }));
    expect(createCommentDbMock).toHaveBeenCalledWith(expect.anything(), "j1", "p1", "hello");
    expect(res).toEqual({ ok: true, error: null });
  });
});