"use client";

import { useQuery } from "@tanstack/react-query";
import { getClient } from "@/lib/supabase/client";

export const useUserQuery = () => {
  const supabase = getClient();
  return useQuery({
    queryKey: ["user"],
    queryFn: async () => {
      const { data, error } = await supabase.auth.getUser();
      if (error) throw error;
      return data.user;
    },
  });
};
