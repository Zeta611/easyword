"use client";

import {
  isServer,
  QueryClient,
  QueryClientProvider,
} from "@tanstack/react-query";
import { useEffect } from "react";
import posthog from "posthog-js";
import { getClient } from "@/lib/supabase/client";

function makeQueryClient() {
  return new QueryClient({
    defaultOptions: {
      queries: {
        staleTime: 60 * 1000,
      },
    },
  });
}

let browserQueryClient: QueryClient | null = null;

function getQueryClient() {
  if (isServer) {
    return makeQueryClient();
  } else {
    if (!browserQueryClient) browserQueryClient = makeQueryClient();
    return browserQueryClient;
  }
}

export default function QueryProvider({
  children,
}: {
  children: React.ReactNode;
}) {
  const queryClient = getQueryClient();

  return (
    <QueryClientProvider client={queryClient}>
      {children}
      {/* Auth listener to keep React Query user cache in sync with Supabase */}
      <AuthSync queryClient={queryClient} />
    </QueryClientProvider>
  );
}

function AuthSync({ queryClient }: { queryClient: QueryClient }) {
  useEffect(() => {
    const supabase = getClient();
    const {
      data: { subscription },
    } = supabase.auth.onAuthStateChange((event, session) => {
      // Keep React Query/posthog in sync with Supabase auth state
      // See https://supabase.com/docs/reference/javascript/auth-onauthstatechange
      if (
        event === "SIGNED_IN" ||
        event === "TOKEN_REFRESHED" ||
        event === "INITIAL_SESSION"
      ) {
        const user = session?.user;
        if (user) {
          posthog.identify(user.id, {
            email: user.email ?? null,
          });
        }
      } else if (event === "SIGNED_OUT") {
        queryClient.setQueryData(["user"], null);
        posthog.reset();
      }
      queryClient.invalidateQueries({ queryKey: ["user"] });
    });

    return () => {
      subscription.unsubscribe();
    };
  }, [queryClient]);

  return null;
}
