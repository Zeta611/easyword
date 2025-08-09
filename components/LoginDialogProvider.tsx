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
  Dialog,
  DialogContent,
  DialogDescription,
  DialogHeader,
  DialogTitle,
} from "./ui/dialog";
import { useUserQuery } from "@/hooks/useUserQuery";
import { LoginButtons } from "@/components/LoginButtons";

type LoginDialogContextValue = {
  openLogin: (next?: string) => void;
  closeLogin: () => void;
  requireAuth: (onAuthed: () => void, next?: string) => void;
};

const LoginDialogContext = createContext<LoginDialogContextValue | null>(null);

export function useLoginDialog(): LoginDialogContextValue {
  const ctx = useContext(LoginDialogContext);
  if (!ctx)
    throw new Error("useLoginDialog must be used within LoginDialogProvider");
  return ctx;
}

export function LoginDialogProvider({
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

  const value = useMemo<LoginDialogContextValue>(
    () => ({ openLogin, closeLogin, requireAuth }),
    [openLogin, closeLogin, requireAuth],
  );

  return (
    <LoginDialogContext value={value}>
      {children}
      <Dialog open={open} onOpenChange={setOpen}>
        <DialogContent className="-translate-y-[calc(33dvh)]">
          <DialogHeader>
            <DialogTitle>로그인이 필요해요</DialogTitle>
            <DialogDescription>계속하려면 로그인해 주세요</DialogDescription>
          </DialogHeader>

          <LoginButtons next={nextPath} />
        </DialogContent>
      </Dialog>
    </LoginDialogContext>
  );
}
