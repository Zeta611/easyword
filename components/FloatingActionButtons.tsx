"use client";

import { Search, SlidersHorizontal } from "lucide-react";
import { Button } from "@/components/ui/button";
import {
  DropdownMenu,
  DropdownMenuContent,
  DropdownMenuLabel,
  DropdownMenuRadioGroup,
  DropdownMenuRadioItem,
  DropdownMenuSeparator,
  DropdownMenuTrigger,
} from "@/components/ui/dropdown-menu";
import { useSearchDialog } from "@/components/SearchDialogProvider";

export type SortOption = "recent" | "popular" | "abc" | "zyx";

export default function FloatingActionButtons({
  sort,
  onChangeSort,
}: {
  sort: SortOption;
  onChangeSort: (value: SortOption) => void;
}) {
  const { openDialog } = useSearchDialog();

  return (
    <div className="fixed bottom-6 left-1/2 z-50 -translate-x-1/2 sm:hidden">
      <div className="flex items-center gap-3">
        {/* Left dummy button (placeholder) */}
        <Button
          variant="outline"
          aria-hidden
          className="bg-accent pointer-events-none h-9 w-16 cursor-default rounded-full p-3 opacity-40"
        >
          <span className="sr-only">placeholder</span>
        </Button>

        {/* Sort - centered (middle column) */}
        <DropdownMenu>
          <DropdownMenuTrigger asChild>
            <Button
              variant="outline"
              className="bg-accent h-9 w-16 rounded-full p-3 shadow-lg hover:cursor-pointer"
            >
              <SlidersHorizontal className="size-5.5" />
              <span className="sr-only">필터</span>
            </Button>
          </DropdownMenuTrigger>
          <DropdownMenuContent className="w-40" side="top" align="center">
            <DropdownMenuLabel>정렬 기준</DropdownMenuLabel>
            <DropdownMenuSeparator />
            <DropdownMenuRadioGroup
              value={sort}
              onValueChange={(value) => onChangeSort(value as SortOption)}
            >
              <DropdownMenuRadioItem value="recent">
                최근 활동순
              </DropdownMenuRadioItem>
              <DropdownMenuRadioItem value="popular">
                댓글 많은순
              </DropdownMenuRadioItem>
              <DropdownMenuRadioItem value="abc">
                알파벳 오름차순
              </DropdownMenuRadioItem>
              <DropdownMenuRadioItem value="zyx">
                알파벳 내림차순
              </DropdownMenuRadioItem>
            </DropdownMenuRadioGroup>
          </DropdownMenuContent>
        </DropdownMenu>

        {/* Search - right (right column) */}
        <Button
          variant="outline"
          className="bg-accent h-9 w-16 rounded-full p-3 shadow-lg hover:cursor-pointer"
          onClick={openDialog}
        >
          <Search className="size-5.5" />
          <span className="sr-only">검색</span>
        </Button>
      </div>
    </div>
  );
}
