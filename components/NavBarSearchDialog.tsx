"use client";

import { matchSorter } from "match-sorter";
import { useRouter } from "next/navigation";
import { useState, useEffect } from "react";
import {
  ChevronRight,
  CornerDownLeft,
  FileSearch,
  Loader2,
  Search,
} from "lucide-react";
import { Button } from "@/components/ui/button";
import {
  CommandDialog,
  CommandEmpty,
  CommandGroup,
  CommandInput,
  CommandItem,
  CommandList,
} from "@/components/ui/command";
import { useSearch } from "@/hooks/useSearch";
import Kbd from "@/components/Kbd";

export default function NavBarSearchDialog() {
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

  const handleSelectResult = (jargonSlug: string) => {
    setOpen(false);
    router.push(`/jargon/${jargonSlug}`);
  };

  return (
    <>
      {/* Desktop search button */}
      <Button
        variant="outline"
        className="bg-accent hidden w-64 justify-between sm:flex"
        onClick={() => setOpen(true)}
      >
        쉬운 전문용어 찾기
        <Kbd>/</Kbd>
      </Button>

      {/* Mobile search button - fixed at bottom center */}
      <Button
        variant="outline"
        className="bg-accent fixed bottom-6 left-1/2 z-50 h-9 w-16 -translate-x-1/2 rounded-full p-3 shadow-lg hover:cursor-pointer sm:hidden"
        onClick={() => setOpen(true)}
      >
        <Search className="size-5.5" />
      </Button>

      {/* Search palette */}
      <CommandDialog
        title="검색창"
        description="쉬운 전문용어를 찾아보세요"
        shouldFilter={false}
        open={open}
        onOpenChange={setOpen}
        className="-translate-y-[calc(33dvh)]"
      >
        <CommandInput
          placeholder="쉬운 전문용어를 찾아보세요..."
          value={query}
          onValueChange={setQuery}
        />
        <CommandList className="max-h-[calc(67dvh-130px)] py-1">
          {isLoading && (
            <div className="my-6 flex items-center justify-center gap-2">
              <Loader2 className="size-4 animate-spin" />
              <span className="text-muted-foreground text-sm">찾는 중...</span>
            </div>
          )}

          {error && (
            <div className="my-6 text-center text-sm text-red-500">{error}</div>
          )}

          {!isLoading && !error && (
            <>
              <CommandEmpty>찾는 결과가 없어요</CommandEmpty>

              {(results.jargons.length > 0 ||
                results.translations.length > 0) && (
                <CommandGroup>
                  <CommandItem
                    onSelect={() => {
                      setOpen(false);
                      router.push(`/?q=${encodeURIComponent(query)}`);
                    }}
                  >
                    <div className="flex items-center gap-2">
                      <FileSearch className="!size-4" />
                      더보기
                    </div>
                  </CommandItem>
                </CommandGroup>
              )}

              {results.jargons.length > 0 && (
                <CommandGroup heading="원어">
                  {matchSorter(results.jargons, query, {
                    keys: ["name"],
                  }).map((result) => (
                    <CommandItem
                      key={result.id}
                      value={result.name}
                      onSelect={() => handleSelectResult(result.jargonSlug)}
                    >
                      <div className="flex flex-1 items-center justify-between">
                        {result.name}
                        <ChevronRight />
                      </div>
                    </CommandItem>
                  ))}
                </CommandGroup>
              )}

              {results.translations.length > 0 && (
                <CommandGroup heading="번역어">
                  {matchSorter(results.translations, query, {
                    keys: ["name"],
                  }).map((result) => (
                    <CommandItem
                      key={result.id}
                      value={result.name}
                      onSelect={() => handleSelectResult(result.jargonSlug)}
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
    </>
  );
}
