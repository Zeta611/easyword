"use client";

import { useState } from "react";
import { cn } from "@/lib/utils";
import { getClient } from "@/lib/supabase/client";
import { Button } from "@/components/ui/button";
import GitHub from "@/components/icons/git-hub";
import Google from "@/components/icons/google";

export function LoginButtons({
  className,
  next,
  ...props
}: React.ComponentPropsWithoutRef<"div"> & { next?: string }) {
  const [error, setError] = useState<string | null>(null);
  const [isLoading, setIsLoading] = useState(false);

  const handleSocialLogin = async (provider: "github" | "google") => {
    const supabase = getClient();
    setIsLoading(true);
    setError(null);

    try {
      let nextPath = next;
      if (typeof window !== "undefined" && !nextPath) {
        nextPath = window.location.pathname + window.location.search;
      }
      const { error } = await supabase.auth.signInWithOAuth({
        provider,
        options: {
          redirectTo: `${window.location.origin}/auth/oauth?next=${encodeURIComponent(
            nextPath ?? "/",
          )}`,
        },
      });

      if (error) throw error;
    } catch (error: unknown) {
      setError(error instanceof Error ? error.message : "An error occurred");
      setIsLoading(false);
    }
  };

  return (
    <div className={cn("flex flex-col gap-2.5", className)} {...props}>
      {error && <p className="text-destructive-500 text-sm">{error}</p>}
      <Button
        onClick={() => handleSocialLogin("github")}
        className="w-full"
        disabled={isLoading}
      >
        <GitHub />
        GitHub로 로그인
      </Button>
      <Button
        onClick={() => handleSocialLogin("google")}
        variant="outline"
        className="w-full"
        disabled={isLoading}
      >
        <Google />
        Google로 로그인
      </Button>
    </div>
  );
}
