"use client";

import { useQuery } from "@tanstack/react-query";
import { getClient } from "@/lib/supabase/client";
import { useUserQuery } from "@/hooks/useUserQuery";

export const useCurrentUserNameAndImage = () => {
  const supabase = getClient();
  const { data: user } = useUserQuery();

  const { data: profile } = useQuery({
    queryKey: ["profile", user?.id],
    enabled: !!user?.id,
    queryFn: async () => {
      if (!user?.id) return null;
      const { data, error } = await supabase
        .from("profile")
        .select("display_name, photo_url")
        .eq("id", user.id)
        .maybeSingle();
      if (error) throw error;
      return data;
    },
  });

  const name = profile?.display_name ?? "";
  const image = profile?.photo_url ?? null;

  return [name, image] as const;
};
