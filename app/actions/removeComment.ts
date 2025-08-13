"use server";

import { MUTATIONS } from "@/lib/supabase/repository";
import { createClient } from "@/lib/supabase/server";

export type RemoveCommentState =
  | {
      ok: false;
      error: string;
    }
  | {
      ok: true;
      error: null;
    };

export type RemoveCommentAction = (
  prevState: RemoveCommentState,
  formData: FormData,
) => Promise<RemoveCommentState>;

export async function removeComment(
  commentId: string,
  _prevState: RemoveCommentState,
  _formData: FormData,
) {
  const supabase = await createClient();
  const { error } = await MUTATIONS.removeComment(supabase, commentId);

  if (error) {
    console.error(error);

    switch (error.code) {
      case "28000":
        return { ok: false, error: "로그인이 필요해요" };
      case "22023":
        return { ok: false, error: "댓글 ID가 필요해요" };
      case "NO_COMMENT":
        return { ok: false, error: "댓글을 찾을 수 없어요" };
      case "42501":
        return { ok: false, error: "이 댓글을 지울 권한이 없어요" };
      default:
        return { ok: false, error: "댓글을 지우는 중 문제가 생겼어요" };
    }
  }
  return { ok: true, error: null };
}
