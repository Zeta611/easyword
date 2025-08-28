"use server";

import { MUTATIONS } from "@/lib/supabase/repository";
import { createClient } from "@/lib/supabase/server";

export type CreateCommentState =
  | { ok: false; error: string }
  | { ok: true; error: null };

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
  const { error } = await MUTATIONS.createComment(
    supabase,
    jargonId,
    parentId,
    content,
  );

  if (error) {
    console.error(error);

    switch (error.code) {
      case "28000":
        return { ok: false, error: "로그인이 필요해요" };
      case "22023":
        return { ok: false, error: "내용을 입력해주세요" };
      case "PARENT_REMOVED":
        return { ok: false, error: "지워진 댓글에는 답글을 달 수 없어요" };
      case "NO_PARENT":
        return { ok: false, error: "부모 댓글을 찾을 수 없어요" };
      default:
        return { ok: false, error: "댓글을 다는 중 문제가 생겼어요" };
    }
  }

  console.info("createComment", jargonId, parentId, content);

  return { ok: true, error: null };
}
