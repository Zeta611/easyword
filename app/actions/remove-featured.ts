"use server";

import { MUTATIONS } from "@/lib/supabase/repository";
import { createClient } from "@/lib/supabase/server";

export type RemoveFeaturedState = { ok: boolean; error: string };

export async function removeFeatured(
  translationId: string,
): Promise<RemoveFeaturedState> {
  const supabase = await createClient();

  // Verify admin role
  const {
    data: { user },
  } = await supabase.auth.getUser();
  if (!user) {
    return { ok: false, error: "로그인이 필요해요" };
  }
  if (user.app_metadata?.userrole !== "admin") {
    return { ok: false, error: "관리자 권한이 필요해요" };
  }

  const { error } = await MUTATIONS.removeFeatured(supabase, translationId);
  if (error) {
    return { ok: false, error: "하이라이트를 삭제하는 중 문제가 생겼어요" };
  }

  return { ok: true, error: "" };
}
