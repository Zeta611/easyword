"use client";

import { useMemo } from "react";
import { useUserQuery } from "@/hooks/useUserQuery";

export const useCurrentUserNameAndImage = () => {
  const { data: user } = useUserQuery();
  const name = useMemo(
    () => (user?.user_metadata?.full_name as string | undefined) ?? "",
    [user],
  );
  const image = useMemo(
    () => (user?.user_metadata?.avatar_url as string | undefined) ?? null,
    [user],
  );
  return [name, image] as const;
};
