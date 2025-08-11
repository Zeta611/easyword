"use server";
import { createClient } from "@/lib/supabase/server";
import { eulLeul } from "@/lib/utils";

export type SuggestTranslationState =
  | { ok: false; error: string }
  | { ok: true; error: null; translationId: string };

export async function suggestTranslation(
  _prevState: SuggestTranslationState,
  formData: FormData,
): Promise<SuggestTranslationState> {
  const translation = (formData.get("translation") as string | null)?.trim();
  if (!translation) return { ok: false, error: "번역을 입력해 주세요" };

  const comment =
    (formData.get("comment") as string | null)?.trim() ||
    `${eulLeul(translation)} 제안해요.`;

  const jargonId = (formData.get("jargonId") as string | null)?.trim();
  if (!jargonId) return { ok: false, error: "잘못된 요청이에요" };

  const supabase = await createClient();

  const { data, error } = await supabase
    .rpc("suggest_translation", {
      p_jargon_id: jargonId,
      p_translation: translation,
      p_comment: comment,
    })
    .single();

  if (error) {
    switch (error.code) {
      case "23505":
        return { ok: false, error: "이미 존재하는 번역이에요" };
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

  return { ok: true, error: null, translationId: data.translation_id };
}
