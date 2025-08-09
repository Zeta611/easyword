"use client";

import { useCallback, useState } from "react";
import { useRouter } from "next/navigation";
import JargonInfiniteList, {
  JargonData,
} from "@/components/JargonInfiniteList";
import FloatingActionButtons, {
  SortOption,
} from "@/components/FloatingActionButtons";

export default function HomePageClient({
  searchQuery,
  initialData,
  initialTotalCount,
  initialSort,
}: {
  searchQuery?: string;
  initialData?: JargonData[];
  initialTotalCount?: number;
  initialSort?: SortOption;
}) {
  const router = useRouter();
  const [sort, setSort] = useState<SortOption>(initialSort || "recent");

  const handleSortChange = useCallback(
    (newSort: SortOption) => {
      setSort(newSort);

      const params = new URLSearchParams();
      if (searchQuery) params.set("q", searchQuery);
      if (newSort !== "recent") params.set("sort", newSort);
      const newUrl = params.toString() ? `/?${params.toString()}` : "/";
      router.replace(newUrl);
    },
    [router, searchQuery],
  );

  return (
    <>
      <JargonInfiniteList
        searchQuery={searchQuery}
        initialData={initialData}
        initialTotalCount={initialTotalCount}
        sort={sort}
        onChangeSort={handleSortChange}
      />
      <FloatingActionButtons sort={sort} onChangeSort={handleSortChange} />
    </>
  );
}
