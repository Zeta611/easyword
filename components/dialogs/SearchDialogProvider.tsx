"use client";

import {
  createContext,
  useCallback,
  useContext,
  useEffect,
  useState,
  Suspense,
} from "react";
import { useRouter, useSearchParams } from "next/navigation";
import { matchSorter } from "match-sorter";
import { ChevronRight, CornerDownLeft, FileSearch } from "lucide-react";
import {
  CommandDialog,
  CommandEmpty,
  CommandGroup,
  CommandInput,
  CommandItem,
  CommandList,
} from "@/components/ui/command";
import { useSearch } from "@/hooks/useSearch";
import Kbd from "@/components/ui/kbd";
import { Skeleton } from "@/components/ui/skeleton";

interface SearchDialogContextValue {
  openDialog: () => void;
  closeDialog: () => void;
}

const SearchDialogContext = createContext<SearchDialogContextValue | null>(
  null,
);

export function useSearchDialog() {
  const ctx = useContext(SearchDialogContext);
  if (!ctx)
    throw new Error("useSearchDialog must be used within SearchDialogProvider");
  return ctx;
}

function SearchMoreItem({
  query,
  setOpen,
}: {
  query: string;
  setOpen: (open: boolean) => void;
}) {
  const router = useRouter();
  const searchParams = useSearchParams();

  const handleSelectMore = () => {
    setOpen(false);
    const params = new URLSearchParams(searchParams.toString());
    if (query.trim()) {
      params.set("q", query.trim());
    } else {
      console.error("query is empty on search");
      params.delete("q");
    }
    const url = params.toString() ? `/?${params.toString()}` : "/";
    router.push(url);
  };

  return (
    <CommandItem onSelect={handleSelectMore}>
      <div className="flex items-center gap-2">
        <FileSearch className="!size-4" />
        <span>더보기</span>
      </div>
    </CommandItem>
  );
}

const SEARCH_LIMIT = 8;

export function SearchDialogProvider({
  children,
}: {
  children: React.ReactNode;
}) {
  const [open, setOpen] = useState(false);

  // Keyboard shortcuts to toggle dialog
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
        setOpen((prev) => !prev);
      }
    };
    document.addEventListener("keydown", down);
    return () => document.removeEventListener("keydown", down);
  }, []);

  const openDialog = useCallback(() => setOpen(true), []);
  const closeDialog = useCallback(() => setOpen(false), []);

  const { query, setQuery, results, isLoading, error } =
    useSearch(SEARCH_LIMIT);

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
    <SearchDialogContext value={{ openDialog, closeDialog }}>
      {children}

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
            <div className="flex flex-col gap-2 px-2 py-1.5">
              {[...Array(SEARCH_LIMIT)].map((_, i) => (
                <Skeleton key={i} className="h-10 w-full" />
              ))}
            </div>
          )}
          {error && (
            <div className="my-6 text-center text-sm text-red-600">{error}</div>
          )}
          {!isLoading && !error && (
            <>
              <CommandEmpty>찾는 결과가 없어요</CommandEmpty>

              {(results.jargons.length > 0 ||
                results.translations.length > 0) && (
                <CommandGroup>
                  <Suspense fallback={<Skeleton className="h-10 w-full" />}>
                    <SearchMoreItem query={query} setOpen={setOpen} />
                  </Suspense>
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
    </SearchDialogContext>
  );
}
