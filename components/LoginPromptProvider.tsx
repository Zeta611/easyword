"use client";

import {
  createContext,
  useCallback,
  useContext,
  useEffect,
  useMemo,
  useState,
} from "react";
import {
  AlertDialog,
  AlertDialogCancel,
  AlertDialogContent,
  AlertDialogDescription,
  AlertDialogFooter,
  AlertDialogHeader,
  AlertDialogTitle,
} from "@/components/ui/alert-dialog";
import { useUserQuery } from "@/hooks/useUserQuery";
import { LoginForm } from "@/components/LoginForm";
import { Separator } from "@/components/ui/separator";

type LoginPromptContextValue = {
  openLogin: (next?: string) => void;
  closeLogin: () => void;
  requireAuth: (onAuthed: () => void, next?: string) => void;
};

const LoginPromptContext = createContext<LoginPromptContextValue | null>(null);

export function useLoginPrompt(): LoginPromptContextValue {
  const ctx = useContext(LoginPromptContext);
  if (!ctx)
    throw new Error("useLoginPrompt must be used within LoginPromptProvider");
  return ctx;
}

export function LoginPromptProvider({
  children,
}: {
  children: React.ReactNode;
}) {
  const { data: user } = useUserQuery();
  const [open, setOpen] = useState(false);
  const [nextPath, setNextPath] = useState<string | undefined>(undefined);

  // Close dialog automatically when user becomes authenticated
  useEffect(() => {
    if (user && open) setOpen(false);
  }, [user, open]);

  const openLogin = useCallback((next?: string) => {
    if (typeof window !== "undefined" && !next) {
      // default to current location
      next = window.location.pathname + window.location.search;
    }
    setNextPath(next);
    setOpen(true);
  }, []);

  const closeLogin = useCallback(() => setOpen(false), []);

  const requireAuth = useCallback(
    (onAuthed: () => void, next?: string) => {
      if (user) {
        onAuthed();
      } else {
        openLogin(next);
      }
    },
    [openLogin, user],
  );

  const value = useMemo<LoginPromptContextValue>(
    () => ({ openLogin, closeLogin, requireAuth }),
    [openLogin, closeLogin, requireAuth],
  );

  return (
    <LoginPromptContext value={value}>
      {children}
      <AlertDialog open={open} onOpenChange={setOpen}>
        <AlertDialogContent className="-translate-y-[calc(33dvh)]">
          <AlertDialogHeader>
            <AlertDialogTitle>로그인이 필요해요</AlertDialogTitle>
            <AlertDialogDescription>
              계속하려면 로그인해 주세요
            </AlertDialogDescription>
          </AlertDialogHeader>

          <LoginForm next={nextPath} />

          <Separator />

          <AlertDialogFooter>
            <AlertDialogCancel>닫기</AlertDialogCancel>
          </AlertDialogFooter>
        </AlertDialogContent>
      </AlertDialog>
    </LoginPromptContext>
  );
}
