"use server";

import { MUTATIONS } from "@/lib/supabase/repository";
import { createClient } from "@/lib/supabase/server";

export type UpdateCommentState =
  | { ok: false; error: string }
  | { ok: true; error: null };

export type UpdateCommentAction = (
  prevState: UpdateCommentState,
  formData: FormData,
) => Promise<UpdateCommentState>;

export async function updateComment(
  commentId: string,
  _prevState: UpdateCommentState,
  formData: FormData,
) {
  const content = (formData.get("content") as string | null)?.trim();
  if (!content) return { ok: false, error: "내용을 입력해주세요" };

  const supabase = await createClient();
  const { error } = await MUTATIONS.updateComment(supabase, commentId, content);

  if (error) {
    console.error(error);

    switch (error.code) {
      case "28000":
        return { ok: false, error: "로그인이 필요해요" };
      case "22023":
        return { ok: false, error: "내용을 입력해주세요" };
      case "NO_COMMENT":
        return { ok: false, error: "댓글을 찾을 수 없어요" };
      case "COMMENT_REMOVED":
        return { ok: false, error: "지워진 댓글은 고칠 수 없어요" };
      case "42501":
        return { ok: false, error: "이 댓글을 고칠 권한이 없어요" };
      default:
        return { ok: false, error: "댓글을 고치는 중 문제가 생겼어요" };
    }
  }
  console.info("updateComment", commentId, content);

  return { ok: true, error: null };
}
