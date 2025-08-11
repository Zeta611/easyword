"use server";

import { createClient } from "@/lib/supabase/server";

export type CreateCommentState =
  | {
      ok: false;
      error: string;
    }
  | {
      ok: true;
      error: null;
    };

export type CreateCommentAction = (
  prevState: CreateCommentState,
  formData: FormData,
) => Promise<CreateCommentState>;

export async function createComment(
  jargonId: string,
  parentId: string | null,
  _prevState: CreateCommentState,
  formData: FormData,
) {
  const content = (formData.get("content") as string | null)?.trim();
  if (!content) return { ok: false, error: "내용을 입력해주세요" };

  const supabase = await createClient();
  const {
    data: { user },
    error: userErr,
  } = await supabase.auth.getUser();
  if (userErr || !user) return { ok: false, error: "로그인이 필요해요" };

  const { error } = await supabase.rpc("create_comment", {
    p_jargon_id: jargonId,
    p_parent_id: parentId ?? undefined,
    p_content: content,
  });
  if (error) return { ok: false, error: "댓글 다는 중 문제가 생겼어요" };

  console.info("createComment", jargonId, parentId, content);

  return { ok: true as const, error: null };
}
