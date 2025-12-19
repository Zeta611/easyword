"use server";

import { MUTATIONS } from "@/lib/supabase/repository";
import { createClient } from "@/lib/supabase/server";

export type UpdateFeaturedOrderState = { ok: boolean; error: string };

export async function updateFeaturedOrder(
  orderedIds: string[],
): Promise<UpdateFeaturedOrderState> {
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

  // Update all featured translations with new order
  for (let i = 0; i < orderedIds.length; i++) {
    const { error } = await MUTATIONS.updateFeaturedOrder(
      supabase,
      orderedIds[i],
      i + 1, // featured rank is 1-based
    );
    if (error) {
      return { ok: false, error: "순서를 변경하는 중 문제가 생겼어요" };
    }
  }

  return { ok: true, error: "" };
}
