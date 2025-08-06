"use client";

import Link from "next/link";
import { useState, useEffect } from "react";
import { useRouter } from "next/navigation";
import { Loader2 } from "lucide-react";
import NavBarAvatar from "./NavBarAvatar";
import { Button } from "@/components/ui/button";
import {
  CommandDialog,
  CommandEmpty,
  CommandGroup,
  CommandInput,
  CommandItem,
  CommandList,
} from "@/components/ui/command";
import { cn } from "@/lib/utils";
import { useSearch } from "@/hooks/useSearch";

export default function NavBar() {
  // Hide "컴퓨터과학/컴퓨터공학" when scrolling down
  const [isVisible, setIsVisible] = useState(true);
  const [lastScrollY, setLastScrollY] = useState(0);
  useEffect(() => {
    const handleScroll = () => {
      const currentScrollY = window.scrollY;

      if (currentScrollY > lastScrollY && currentScrollY > 50) {
        setIsVisible(false);
      } else if (currentScrollY < lastScrollY) {
        setIsVisible(true);
      }
      setLastScrollY(currentScrollY);
    };

    window.addEventListener("scroll", handleScroll, { passive: true });
    return () => window.removeEventListener("scroll", handleScroll);
  }, [lastScrollY]);

  const [open, setOpen] = useState(false);

  useEffect(() => {
    const down = (e: KeyboardEvent) => {
      if ((e.key === "k" && (e.metaKey || e.ctrlKey)) || e.key === "/") {
        if (
          (e.target instanceof HTMLElement && e.target.isContentEditable) ||
          e.target instanceof HTMLInputElement ||
          e.target instanceof HTMLTextAreaElement ||
          e.target instanceof HTMLSelectElement
        ) {
          return;
        }
        e.preventDefault();
        setOpen((open) => !open);
      }
    };

    document.addEventListener("keydown", down);
    return () => document.removeEventListener("keydown", down);
  }, []);

  const { query, setQuery, results, isLoading, error } = useSearch();
  // Clear search when dialog closes
  useEffect(() => {
    if (!open) {
      setQuery("");
    }
  }, [open, setQuery]);

  const router = useRouter();

  const handleSelectResult = (jargonId: string) => {
    setOpen(false);
    router.push(`/jargon/${jargonId}`);
  };

  return (
    <nav className="sticky top-0 z-50">
      <div className="mb-4 flex items-start justify-between pt-4">
        <Link href="/">
          <div className="flex flex-col items-center gap-1">
            <span className="rounded-sm bg-black px-3 py-2 text-xl font-black text-white transition-all ease-in-out hover:rounded-3xl hover:text-lg">
              쉬운 전문용어
            </span>
            <span
              className={cn(
                "text-sm font-bold transition-colors duration-300",
                isVisible ? "text-gray-900" : "text-transparent",
              )}
            >
              컴퓨터과학/컴퓨터공학
            </span>
          </div>
        </Link>
        <div className="flex items-center gap-6">
          <Button
            variant="outline"
            className="bg-accent w-64 justify-between"
            onClick={() => setOpen(true)}
          >
            쉬운 전문용어 검색
            <kbd className="bg-muted pointer-events-none hidden h-5.5 items-center gap-1 rounded border px-1 font-mono text-xs sm:flex">
              <span className="mb-[-2.5]">⌘</span>K
            </kbd>
          </Button>
          <CommandDialog open={open} onOpenChange={setOpen}>
            <CommandInput
              placeholder="쉬운 전문용어를 검색하세요..."
              value={query}
              onValueChange={setQuery}
            />
            <CommandList className="py-1">
              {isLoading && (
                <div className="my-6 flex items-center justify-center gap-2">
                  <Loader2 className="size-4 animate-spin" />
                  <span className="text-muted-foreground text-sm">
                    검색 중...
                  </span>
                </div>
              )}

              {error && (
                <div className="my-6 text-center text-sm text-red-500">
                  {error}
                </div>
              )}

              {!isLoading && !error && (
                <>
                  <CommandEmpty>검색 결과가 없어요</CommandEmpty>

                  {results.original.length > 0 && (
                    <CommandGroup heading="원어">
                      {results.original.map((result) => (
                        <CommandItem
                          key={result.id}
                          value={result.name}
                          onSelect={() => handleSelectResult(result.jargonId)}
                        >
                          {result.name}
                        </CommandItem>
                      ))}
                    </CommandGroup>
                  )}

                  {results.translation.length > 0 && (
                    <CommandGroup heading="번역어">
                      {results.translation.map((result) => (
                        <CommandItem
                          key={result.id}
                          value={result.name}
                          onSelect={() => handleSelectResult(result.jargonId)}
                        >
                          {result.name}
                        </CommandItem>
                      ))}
                    </CommandGroup>
                  )}
                </>
              )}
            </CommandList>
          </CommandDialog>
          <NavBarAvatar />
        </div>
      </div>
    </nav>
  );
}
