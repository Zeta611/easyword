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
  const {
    data: { user },
    error: userErr,
  } = await supabase.auth.getUser();
  if (userErr || !user) return { ok: false, error: "로그인이 필요해요" };

  const { error } = await MUTATIONS.removeComment(supabase, commentId).eq(
    "author_id",
    user.id,
  );
  if (error) return { ok: false, error: "댓글 삭제 중 문제가 생겼어요" };

  console.info("removeComment", commentId);

  return { ok: true as const, error: null };
}