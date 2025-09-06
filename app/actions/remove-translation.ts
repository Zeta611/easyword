"use server";

import { MUTATIONS } from "@/lib/supabase/repository";
import { createClient } from "@/lib/supabase/server";

export type RemoveTranslationState =
  | { ok: false; error: string }
  | { ok: true; error: null };

export type RemoveTranslationAction = (
  prevState: RemoveTranslationState,
  formData: FormData,
) => Promise<RemoveTranslationState>;

export async function removeTranslation(
  translationId: string,
  _prevState: RemoveTranslationState,
  _formData: FormData,
): Promise<RemoveTranslationState> {
  const supabase = await createClient();
  const { error } = await MUTATIONS.removeTranslation(supabase, translationId);

  if (error) {
    switch (error.code) {
      case "28000":
        return { ok: false, error: "로그인이 필요해요" };
      case "22023":
        return { ok: false, error: "잘못된 요청이에요" };
      case "NO_TRANSLATION":
        return { ok: false, error: "번역을 찾을 수 없어요" };
      case "42501":
        return { ok: false, error: "이 번역을 지울 권한이 없어요" };
      default:
        return { ok: false, error: "번역을 지우는 중 문제가 생겼어요" };
    }
  }

  return { ok: true, error: null };
}
