"use server";

import { MUTATIONS, QUERIES } from "@/lib/supabase/repository";
import { createClient } from "@/lib/supabase/server";

export type ToggleFeaturedState = {
  ok: boolean;
  error: string;
  isFeatured: boolean;
};

export async function toggleFeatured(
  translationId: string,
): Promise<ToggleFeaturedState> {
  const supabase = await createClient();

  // Verify admin role
  const {
    data: { user },
  } = await supabase.auth.getUser();
  if (!user) {
    return { ok: false, error: "로그인이 필요해요", isFeatured: false };
  }
  if (user.app_metadata?.userrole !== "admin") {
    return { ok: false, error: "관리자 권한이 필요해요", isFeatured: false };
  }

  // Check if translation is currently featured
  const { data: translation, error: translationError } = await supabase
    .from("translation")
    .select("featured")
    .eq("id", translationId)
    .single();

  if (translationError) {
    return {
      ok: false,
      error: "번역 정보를 불러오는 중 문제가 생겼어요",
      isFeatured: false,
    };
  }

  const isCurrentlyFeatured = translation.featured !== null;

  if (isCurrentlyFeatured) {
    // Remove from featured
    const { error } = await MUTATIONS.removeFeatured(supabase, translationId);
    if (error) {
      return {
        ok: false,
        error: "하이라이트에서 제거하는 중 문제가 생겼어요",
        isFeatured: true,
      };
    }
    return { ok: true, error: "", isFeatured: false };
  } else {
    // Add to featured - get all featured translations to find the max index
    const { data: featuredData, error: queryError } =
      await QUERIES.listAllFeaturedTranslations(supabase);
    if (queryError) {
      return {
        ok: false,
        error: "하이라이트 목록을 불러오는 중 문제가 생겼어요",
        isFeatured: false,
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
      return {
        ok: false,
        error: "하이라이트로 추가하는 중 문제가 생겼어요",
        isFeatured: false,
      };
    }
    return { ok: true, error: "", isFeatured: true };
  }
}
