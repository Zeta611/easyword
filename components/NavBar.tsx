"use client";

import Link from "next/link";
import { useState, useEffect } from "react";
import { useRouter } from "next/navigation";
import {
  ChevronRight,
  CornerDownLeft,
  FileSearch,
  Loader2,
} from "lucide-react";
import { matchSorter } from "match-sorter";
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
import Kbd from "@/components/Kbd";

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

  const { query, setQuery, results, isLoading, error } = useSearch(8);
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
            <Kbd>/</Kbd>
          </Button>
          <CommandDialog
            title="검색창"
            description="쉬운 전문용어를 검색하세요"
            shouldFilter={false}
            open={open}
            onOpenChange={setOpen}
          >
            <CommandInput
              placeholder="쉬운 전문용어를 검색하세요..."
              value={query}
              onValueChange={setQuery}
            />
            <CommandList className="max-h-[calc(100dvh-130px)] py-1">
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

                  {(results.original.length > 0 ||
                    results.translation.length > 0) && (
                    <CommandGroup>
                      <CommandItem
                        onSelect={() => {
                          setOpen(false);
                          // router.push("/jargon");
                        }}
                      >
                        <div className="flex items-center gap-2">
                          <FileSearch className="!size-4" />
                          더보기
                        </div>
                      </CommandItem>
                    </CommandGroup>
                  )}

                  {results.original.length > 0 && (
                    <CommandGroup heading="원어">
                      {matchSorter(results.original, query, {
                        keys: ["name"],
                      }).map((result) => (
                        <CommandItem
                          key={result.id}
                          value={result.name}
                          onSelect={() => handleSelectResult(result.jargonId)}
                        >
                          <div className="flex flex-1 items-center justify-between">
                            {result.name}
                            <ChevronRight />
                          </div>
                        </CommandItem>
                      ))}
                    </CommandGroup>
                  )}

                  {results.translation.length > 0 && (
                    <CommandGroup heading="번역어">
                      {matchSorter(results.translation, query, {
                        keys: ["name"],
                      }).map((result) => (
                        <CommandItem
                          key={result.id}
                          value={result.name}
                          onSelect={() => handleSelectResult(result.jargonId)}
                        >
                          <div className="flex flex-1 items-center justify-between">
                            {result.name}
                            <ChevronRight />
                          </div>
                        </CommandItem>
                      ))}
                    </CommandGroup>
                  )}
                </>
              )}
            </CommandList>
            <div className="text-muted-foreground bg-accent flex h-10 items-center gap-1.5 border-t px-4 text-xs font-medium">
              바로가기
              <Kbd>
                <CornerDownLeft className="size-2.5" />
              </Kbd>
            </div>
          </CommandDialog>
          <NavBarAvatar />
        </div>
      </div>
    </nav>
  );
}
