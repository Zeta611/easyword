"use client";

import { useRouter } from "next/navigation";
import { getClient } from "@/lib/supabase/client";
import { Button } from "@/components/ui/button";
import { useQueryClient } from "@tanstack/react-query";

export function LogoutButton() {
  const router = useRouter();
  const queryClient = useQueryClient();

  const logout = async () => {
    const supabase = getClient();
    await supabase.auth.signOut();
    queryClient.setQueryData(["user"], null);
    queryClient.invalidateQueries({ queryKey: ["user"] });
    router.push("/auth/login");
  };

  return (
    <Button onClick={logout} variant="destructive">
      로그아웃
    </Button>
  );
}
