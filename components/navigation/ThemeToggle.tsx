"use client";

import { useEffect, useState, useCallback } from "react";
import { Moon, Sun } from "lucide-react";
import { Button } from "@/components/ui/button";

const THEME_COOKIE_NAME = "theme";
const ONE_YEAR_SECONDS = 60 * 60 * 24 * 365;

type ThemeMode = "light" | "dark";

function getCookie(name: string): string | null {
  if (typeof document === "undefined") return null;
  const match = document.cookie.match(new RegExp(`(?:^|; )${name}=([^;]*)`));
  return match ? decodeURIComponent(match[1]) : null;
}

function setCookie(name: string, value: string, maxAgeSeconds: number) {
  if (typeof document === "undefined") return;
  document.cookie = `${name}=${encodeURIComponent(value)}; path=/; max-age=${maxAgeSeconds}`;
}

export default function ThemeToggle() {
  const [theme, setTheme] = useState<ThemeMode>("light");

  useEffect(() => {
    const cookieTheme = getCookie(THEME_COOKIE_NAME) as ThemeMode | null;
    // Prefer cookie; otherwise fall back to system preference on first load.
    const systemPrefersDark =
      window.matchMedia &&
      window.matchMedia("(prefers-color-scheme: dark)").matches;
    const initialTheme: ThemeMode =
      cookieTheme ?? (systemPrefersDark ? "dark" : "light");
    document.documentElement.classList.toggle("dark", initialTheme === "dark");
    setTheme(initialTheme);
  }, []);

  const applyTheme = useCallback((next: ThemeMode) => {
    const root = document.documentElement;
    root.classList.toggle("dark", next === "dark");
    setCookie(THEME_COOKIE_NAME, next, ONE_YEAR_SECONDS);
    setTheme(next);
  }, []);

  const toggle = useCallback(() => {
    applyTheme(theme === "dark" ? "light" : "dark");
  }, [theme, applyTheme]);

  return (
    <Button
      variant="ghost"
      size="icon"
      aria-label={theme === "dark" ? "라이트 모드로 전환" : "다크 모드로 전환"}
      className="text-muted-foreground"
      onClick={toggle}
    >
      {theme === "dark" ? (
        <Sun className="size-5" />
      ) : (
        <Moon className="size-5" />
      )}
    </Button>
  );
}
