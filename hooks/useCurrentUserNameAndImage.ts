"use client";

import { useQuery } from "@tanstack/react-query";
import { getClient } from "@/lib/supabase/client";
import { useUserQuery } from "@/hooks/useUserQuery";
import { DB } from "@/lib/supabase/repository";

export const useCurrentUserNameAndImage = () => {
  const supabase = getClient();
  const { data: user } = useUserQuery();

  const { data: profile } = useQuery({
    queryKey: ["profile", user?.id],
    enabled: !!user?.id,
    queryFn: async ({ signal }) => {
      if (!user?.id) return null;
      const { data, error } = await DB.getNameAndPhoto(supabase, user.id, {
        signal,
      });
      if (error) throw error;
      return data;
    },
  });

  const name = profile?.display_name ?? "";
  const image = profile?.photo_url ?? null;

  return [name, image] as const;
};
