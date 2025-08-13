"use client";

import { Search, SlidersHorizontal, Filter } from "lucide-react";
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
import { useSearchDialog } from "@/components/dialogs/search-dialog-provider";

type SortOption = "recent" | "popular" | "abc" | "zyx";

interface FloatingActionButtonsProps {
  sortCategories: { sort: SortOption; categories: string[] | null };
  onChangeSortCategories: (value: {
    sort?: SortOption;
    categories?: string[] | null;
  }) => void;
  openFilterDialog: () => void;
}

export default function FloatingActionButtons({
  sortCategories,
  onChangeSortCategories,
  openFilterDialog,
}: FloatingActionButtonsProps) {
  const { openDialog: openSearch } = useSearchDialog();

  return (
    <div className="fixed bottom-6 left-1/2 z-50 -translate-x-1/2 sm:hidden">
      <div className="flex items-center gap-3">
        {/* Filter (left column) */}
        <Button
          variant="outline"
          className="bg-accent/30 h-9 w-16 rounded-full p-3 backdrop-blur-xs active:scale-95 active:shadow-inner"
          onClick={openFilterDialog}
        >
          <Filter className="size-5.5" />
          <span className="sr-only">필터</span>
        </Button>

        {/* Sort - centered (middle column) */}
        <DropdownMenu>
          <DropdownMenuTrigger asChild>
            <Button
              variant="outline"
              className="bg-accent/30 h-9 w-16 rounded-full p-3 backdrop-blur-xs active:scale-95 active:shadow-inner data-[state=open]:scale-95 data-[state=open]:shadow-inner"
            >
              <SlidersHorizontal className="size-5.5" />
              <span className="sr-only">필터</span>
            </Button>
          </DropdownMenuTrigger>
          <DropdownMenuContent className="w-40" side="top" align="center">
            <DropdownMenuLabel>정렬 기준</DropdownMenuLabel>
            <DropdownMenuSeparator />
            <DropdownMenuRadioGroup
              value={sortCategories.sort}
              onValueChange={(value) =>
                onChangeSortCategories({ sort: value as SortOption })
              }
            >
              <DropdownMenuRadioItem value="recent">
                최근 활동순
              </DropdownMenuRadioItem>
              <DropdownMenuRadioItem value="popular">
                댓글 많은순
              </DropdownMenuRadioItem>
              <DropdownMenuRadioItem value="abc">ABC순</DropdownMenuRadioItem>
              <DropdownMenuRadioItem value="zyx">ZYX순</DropdownMenuRadioItem>
            </DropdownMenuRadioGroup>
          </DropdownMenuContent>
        </DropdownMenu>

        {/* Search - right (right column) */}
        <Button
          variant="outline"
          className="bg-accent/30 h-9 w-16 rounded-full p-3 backdrop-blur-xs active:scale-95 active:shadow-inner"
          onClick={openSearch}
        >
          <Search className="size-5.5" />
          <span className="sr-only">검색</span>
        </Button>
      </div>
    </div>
  );
}
