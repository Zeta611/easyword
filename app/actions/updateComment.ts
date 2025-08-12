"use server";

import { MUTATIONS } from "@/lib/supabase/repository";
import { createClient } from "@/lib/supabase/server";

export type UpdateCommentState =
  | {
      ok: false;
      error: string;
    }
  | {
      ok: true;
      error: null;
    };

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
  const {
    data: { user },
    error: userErr,
  } = await supabase.auth.getUser();
  if (userErr || !user) return { ok: false, error: "로그인이 필요해요" };

  const { error } = await MUTATIONS.updateComment(supabase, commentId, content).eq(
    "author_id",
    user.id,
  );
  if (error) return { ok: false, error: "댓글 수정 중 문제가 생겼어요" };

  console.info("updateComment", commentId, content);

  return { ok: true as const, error: null };
}