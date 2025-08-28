"use server";

import { MUTATIONS } from "@/lib/supabase/repository";
import { createClient } from "@/lib/supabase/server";

export type UpdateJargonState =
  | { ok: false; error: string }
  | { ok: true; error: null; jargonSlug: string };

export type UpdateJargonAction = (
  prevState: UpdateJargonState,
  formData: FormData,
) => Promise<UpdateJargonState>;

export async function updateJargon(
  jargonId: string,
  _prevState: UpdateJargonState,
  formData: FormData,
): Promise<UpdateJargonState> {
  const name = (formData.get("name") as string | null)?.trim();
  if (!name) return { ok: false, error: "용어 이름을 입력해주세요" };

  const supabase = await createClient();
  const { data, error } = await MUTATIONS.updateJargon(
    supabase,
    jargonId,
    name,
  );

  if (error) {
    switch (error.code) {
      case "28000":
        return { ok: false, error: "로그인이 필요해요" };
      case "22023":
        return { ok: false, error: "올바른 값을 입력해주세요" };
      case "NO_JARGON":
        return { ok: false, error: "용어를 찾을 수 없어요" };
      case "23505":
        return {
          ok: false,
          error: "이미 존재하는 용어이거나 짧은 이름(slug)이 겹쳐요",
        };
      case "42501":
        return { ok: false, error: "이 용어를 고칠 권한이 없어요" };
      default:
        return { ok: false, error: "용어를 고치는 중 문제가 생겼어요" };
    }
  }

  return { ok: true, error: null, jargonSlug: data.jargon_slug };
}
