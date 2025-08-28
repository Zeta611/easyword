"use server";

import { MUTATIONS } from "@/lib/supabase/repository";
import { createClient } from "@/lib/supabase/server";

export type RemoveJargonState =
  | { ok: false; error: string }
  | { ok: true; error: null };

export type RemoveJargonAction = (
  prevState: RemoveJargonState,
  formData: FormData,
) => Promise<RemoveJargonState>;

export async function removeJargon(
  jargonId: string,
  _prevState: RemoveJargonState,
  _formData: FormData,
): Promise<RemoveJargonState> {
  const supabase = await createClient();
  const { error } = await MUTATIONS.removeJargon(supabase, jargonId);

  if (error) {
    switch (error.code) {
      case "28000":
        return { ok: false, error: "로그인이 필요해요" };
      case "22023":
        return { ok: false, error: "잘못된 요청이에요" };
      case "NO_JARGON":
        return { ok: false, error: "용어를 찾을 수 없어요" };
      case "42501":
        return { ok: false, error: "이 용어를 지울 권한이 없어요" };
      default:
        return { ok: false, error: "용어를 지우는 중 문제가 생겼어요" };
    }
  }

  return { ok: true, error: null };
}
