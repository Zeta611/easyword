"use server";

import { MUTATIONS } from "@/lib/supabase/repository";
import { createClient } from "@/lib/supabase/server";

export type UpdateTranslationState =
  | { ok: false; error: string }
  | { ok: true; error: null };

export type UpdateTranslationAction = (
  prevState: UpdateTranslationState,
  formData: FormData,
) => Promise<UpdateTranslationState>;

export async function updateTranslation(
  translationId: string,
  _prevState: UpdateTranslationState,
  formData: FormData,
): Promise<UpdateTranslationState> {
  const name = (formData.get("name") as string | null)?.trim();
  if (!name) return { ok: false, error: "번역을 입력해주세요" };

  const supabase = await createClient();
  const { error } = await MUTATIONS.updateTranslation(
    supabase,
    translationId,
    name,
  );

  if (error) {
    switch (error.code) {
      case "28000":
        return { ok: false, error: "로그인이 필요해요" };
      case "22023":
        return { ok: false, error: "올바른 값을 입력해주세요" };
      case "NO_TRANSLATION":
        return { ok: false, error: "번역을 찾을 수 없어요" };
      case "23505":
        return { ok: false, error: "이미 존재하는 번역이에요" };
      case "42501":
        return { ok: false, error: "이 번역을 고칠 권한이 없어요" };
      default:
        return { ok: false, error: "번역을 고치는 중 문제가 생겼어요" };
    }
  }

  return { ok: true, error: null };
}
