"use server";

import { MUTATIONS } from "@/lib/supabase/repository";
import { createClient } from "@/lib/supabase/server";
import { eulLeul } from "@/lib/utils";

export type SuggestJargonState =
  | {
      ok: false;
      error: string;
    }
  | {
      ok: true;
      error: null;
      jargonSlug: string;
    };

export type SuggestJargonAction = (
  prevState: SuggestJargonState,
  formData: FormData,
) => Promise<SuggestJargonState>;

export async function suggestJargon(
  _prevState: SuggestJargonState,
  formData: FormData,
): Promise<SuggestJargonState> {
  const jargon = (formData.get("jargon") as string | null)?.trim();
  if (!jargon) return { ok: false, error: "용어를 입력해 주세요" };

  const noTranslation =
    ((formData.get("noTranslation") as string | null) ?? "false") === "true";
  const translation =
    (formData.get("translation") as string | null)?.trim() ?? "";
  if (!noTranslation && !translation) {
    return {
      ok: false,
      error: "번역을 입력하거나 '번역 없이 제안하기'를 선택해 주세요",
    };
  }

  const comment =
    (formData.get("comment") as string | null)?.trim() ||
    (noTranslation
      ? `${jargon}의 번역이 필요해요.`
      : `${eulLeul(translation)} 제안해요.`);

  const categoryIds = (formData.getAll("categoryIds") as string[])
    .map((cid) => Number(cid))
    .filter((n) => !Number.isNaN(n));

  const supabase = await createClient();

  const { data, error } = await MUTATIONS.suggestJargon(
    supabase,
    jargon,
    noTranslation,
    translation,
    comment,
    categoryIds,
  );

  if (error) {
    switch (error.code) {
      case "23505":
        return { ok: false, error: "이미 존재하는 용어예요" };
      case "23503":
        return { ok: false, error: "존재하지 않는 분야가 포함되어 있어요" };
      case "28000":
        return { ok: false, error: "로그인이 필요해요" };
      default:
        return {
          ok: false,
          error:
            `${error.message} (에러 코드: ${error.code})` ||
            `문제가 발생했어요 (에러 코드: ${error.code})`,
        };
    }
  }

  return { ok: true, error: null, jargonSlug: data.jargon_slug };
}
