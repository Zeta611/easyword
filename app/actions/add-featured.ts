"use server";

import { MUTATIONS, QUERIES } from "@/lib/supabase/repository";
import { createClient } from "@/lib/supabase/server";

export type AddFeaturedState = { ok: boolean; error: string };

export async function addFeatured(
  translationId: string,
): Promise<AddFeaturedState> {
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

  // Get all featured translations to find the max index
  const { data: featuredData, error: queryError } =
    await QUERIES.listAllFeaturedTranslations(supabase);
  if (queryError) {
    return {
      ok: false,
      error: "하이라이트 목록을 불러오는 중 문제가 생겼어요",
    };
  }

  // Find the next featured index (max + 1, or 1 if no featured items)
  const maxFeatured =
    featuredData && featuredData.length > 0
      ? Math.max(...featuredData.map((t) => t.featured ?? 0))
      : 0;
  const nextFeatured = maxFeatured + 1;

  // Update the translation with the new featured rank
  const { error } = await MUTATIONS.updateFeaturedOrder(
    supabase,
    translationId,
    nextFeatured,
  );
  if (error) {
    return { ok: false, error: "하이라이트로 추가하는 중 문제가 생겼어요" };
  }

  return { ok: true, error: "" };
}
