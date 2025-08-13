"use client";

import { useQuery } from "@tanstack/react-query";
import { getClient } from "@/lib/supabase/client";

export const useUserQuery = () => {
  const supabase = getClient();
  return useQuery({
    queryKey: ["user"],
    queryFn: async () => {
      // NOTE: getUser will error if the user is not logged in. This will then cause TanStack Query to retry and show a loading state.
      const { data, error } = await supabase.auth.getSession();
      if (error) throw error;
      return data.session?.user ?? null;
    },
  });
};
