"use server";

import { MUTATIONS } from "@/lib/supabase/repository";
import { createClient } from "@/lib/supabase/server";

export type UpdateJargonCategoriesState =
  | { ok: false; error: string }
  | { ok: true; error: null };

export type UpdateJargonCategoriesAction = (
  prevState: UpdateJargonCategoriesState,
  formData: FormData,
) => Promise<UpdateJargonCategoriesState>;

export async function updateJargonCategories(
  jargonId: string,
  _prevState: UpdateJargonCategoriesState,
  formData: FormData,
): Promise<UpdateJargonCategoriesState> {
  const categoryIds = (formData.getAll("categoryIds") as string[])
    .map((id) => Number(id))
    .filter((n) => !Number.isNaN(n));

  const supabase = await createClient();
  const { error } = await MUTATIONS.updateJargonCategories(
    supabase,
    jargonId,
    categoryIds,
  );

  if (error) {
    switch (error.code) {
      case "28000":
        return { ok: false, error: "로그인이 필요해요" };
      case "22023":
        return { ok: false, error: "잘못된 요청이에요" };
      case "NO_JARGON":
        return { ok: false, error: "용어를 찾을 수 없어요" };
      case "23503":
        return { ok: false, error: "존재하지 않는 분야가 있어요" };
      default:
        return { ok: false, error: "분야를 업데이트하는 중 문제가 생겼어요" };
    }
  }

  return { ok: true, error: null };
}
