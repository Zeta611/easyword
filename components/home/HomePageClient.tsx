"use client";

import { useCallback, useState } from "react";
import { useRouter } from "next/navigation";
import { useQuery } from "@tanstack/react-query";
import JargonInfiniteList, {
  JargonData,
} from "@/components/jargon/JargonInfiniteList";
import FloatingActionButtons from "@/components/home/FloatingActionButtons";
import { getClient } from "@/lib/supabase/client";
import { DB } from "@/lib/supabase/repository";
import {
  Dialog,
  DialogContent,
  DialogHeader,
  DialogDescription,
  DialogFooter,
  DialogTitle,
} from "@/components/ui/dialog";
import { Button } from "@/components/ui/button";
import { MultiSelect } from "@/components/ui/multi-select";

export type SortOption = "recent" | "popular" | "abc" | "zyx";

export default function HomePageClient({
  searchQuery,
  initialData,
  initialTotalCount,
  initialSortCategories,
}: {
  searchQuery: string;
  initialData: JargonData[];
  initialTotalCount: number;
  initialSortCategories: { sort: SortOption; categories: string[] | null };
}) {
  const router = useRouter();
  const [sortCategories, setSortCategories] = useState(initialSortCategories);

  const [openFilterDialog, setOpenFilterDialog] = useState(false);
  const supabase = getClient();

  const { data: categories, isLoading: isLoadingCategories } = useQuery({
    queryKey: ["categories"],
    enabled: openFilterDialog,
    queryFn: async ({ signal }) => {
      const { data, error } = await DB.listCategories(supabase, { signal });
      if (error) throw error;
      return data;
    },
  });

  const handleSortCategoriesChange = useCallback(
    ({
      sort,
      categories,
    }: {
      sort?: SortOption;
      categories?: string[] | null;
    }) => {
      const params = new URLSearchParams();
      if (searchQuery) params.set("q", searchQuery);

      if (sort) {
        setSortCategories((sc) => ({ ...sc, sort }));
        if (sort !== "recent") {
          params.set("sort", sort);
        }
      }
      if (categories !== undefined) {
        setSortCategories((sc) => ({ ...sc, categories }));
        if (categories === null) {
          params.delete("categories");
        } else {
          params.set("categories", categories.toString());
        }
      }

      const newUrl = params.toString() ? `/?${params.toString()}` : "/";
      router.replace(newUrl);
    },
    [router, searchQuery, setSortCategories],
  );

  return (
    <>
      <JargonInfiniteList
        searchQuery={searchQuery}
        initialData={initialData}
        initialTotalCount={initialTotalCount}
        sortCategories={sortCategories}
        onChangeSortCategories={handleSortCategoriesChange}
        openFilterDialog={() => setOpenFilterDialog(true)}
      />
      <FloatingActionButtons
        sortCategories={sortCategories}
        onChangeSortCategories={handleSortCategoriesChange}
        openFilterDialog={() => setOpenFilterDialog(true)}
      />
      <Dialog open={openFilterDialog} onOpenChange={setOpenFilterDialog}>
        <DialogContent className="-translate-y-[calc(33dvh)]">
          <DialogHeader>
            <DialogTitle>분야 필터</DialogTitle>
            <DialogDescription>보여질 분야들을 선택하세요</DialogDescription>
          </DialogHeader>

          <MultiSelect
            variant="outline"
            options={(categories ?? []).map((c) => ({
              value: c.acronym,
              label: `${c.acronym} (${c.name})`,
              shortLabel: c.acronym,
            }))}
            defaultValue={
              sortCategories.categories === null
                ? (categories?.map((c) => c.acronym) ?? [])
                : sortCategories.categories
            }
            onValueChange={(c) => {
              // If all categories are selected, set categories to null
              handleSortCategoriesChange({
                categories: c.length === categories?.length ? null : c,
              });
            }}
            closeOnSelect={false}
            hideSelectAll={false}
            placeholder={isLoadingCategories ? "불러오는 중..." : "분야 선택"}
            disabled={isLoadingCategories}
            popoverClassName="w-full"
          />

          <DialogFooter>
            <Button onClick={() => setOpenFilterDialog(false)}>닫기</Button>
          </DialogFooter>
        </DialogContent>
      </Dialog>
    </>
  );
}
