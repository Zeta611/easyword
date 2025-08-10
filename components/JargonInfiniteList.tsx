"use client";

import Link from "next/link";
import { useRouter } from "next/navigation";
import { SlidersHorizontal, X } from "lucide-react";
import { useCallback, useMemo, useRef } from "react";
import equal from "fast-deep-equal";
import { useInfiniteQuery, useQuery } from "@tanstack/react-query";
import { getClient } from "@/lib/supabase/client";
import JargonCard from "@/components/JargonCard";
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
import { Skeleton } from "@/components/ui/skeleton";

export interface JargonData {
  id: string;
  name: string;
  slug: string;
  updated_at: string;
  translations: string[];
  categories: string[];
  comment_count: number;
}

interface JargonInfiniteListProps {
  searchQuery: string;
  initialData: JargonData[];
  initialTotalCount: number;
  sort: SortOption;
  onChangeSort: (value: SortOption) => void;
}

type SortOption = "recent" | "popular" | "abc" | "zyx";

const PAGE_SIZE = 32;

export default function JargonInfiniteList({
  searchQuery,
  initialData,
  initialTotalCount,
  sort,
  onChangeSort,
}: JargonInfiniteListProps) {
  const router = useRouter();
  const supabase = getClient();

  const initialQueryKeyRef = useRef(["jargons", { q: searchQuery, sort }]);
  const queryKey = ["jargons", { q: searchQuery, sort }];

  const {
    data: jargons,
    isLoading,
    isFetchingNextPage,
    fetchNextPage,
    hasNextPage,
    error,
  } = useInfiniteQuery({
    queryKey,
    initialPageParam: 0,
    queryFn: async ({ pageParam }) => {
      const { data, error } = await supabase.rpc(
        "search_jargons_with_translations",
        {
          search_query: searchQuery,
          limit_count: PAGE_SIZE,
          offset_count: pageParam,
          sort_option: sort,
        },
      );
      if (error) throw error;
      return data.map((it) => ({
        id: it.id,
        name: it.name,
        slug: it.slug,
        updated_at: it.updated_at,
        // @ts-expect-error JSON handling
        translations: it.translations.map((t) => t.name),
        // @ts-expect-error JSON handling
        categories: it.categories.map((c) => c.acronym),
        // @ts-expect-error JSON handling
        comment_count: it.comments[0].count,
      }));
    },
    getNextPageParam: (lastPage, allPages) => {
      if (!lastPage || lastPage.length < PAGE_SIZE) return null;
      return allPages.reduce((acc, p) => acc + p.length, 0);
    },
    initialData:
      // NOTE: Initial data should not be used when the query changes
      initialData && equal(queryKey, initialQueryKeyRef.current)
        ? {
            pages: [initialData],
            pageParams: [0],
          }
        : undefined,
  });

  const flatData = useMemo(() => jargons?.pages.flat() ?? [], [jargons?.pages]);

  const { data: totalCount } = useQuery({
    queryKey: ["jargons-count", { q: searchQuery }],
    queryFn: async () => {
      const { data, error } = await supabase.rpc("count_search_jargons", {
        search_query: searchQuery,
      });
      if (error) throw error;
      return data;
    },
    initialData: initialTotalCount,
  });

  // Update URL when sort changes
  const handleSortChange = useCallback(
    (newSort: SortOption) => {
      onChangeSort(newSort);

      // Build new URL with sort parameter
      const params = new URLSearchParams();
      if (searchQuery) {
        params.set("q", searchQuery);
      }
      if (newSort !== "recent") {
        params.set("sort", newSort);
      }

      const newUrl = params.toString() ? `/?${params.toString()}` : "/";
      router.replace(newUrl);
    },
    [searchQuery, router, onChangeSort],
  );

  if (error) {
    return (
      <div className="flex flex-col items-center justify-center py-12">
        <p className="text-red-600">오류가 발생했습니다</p>
        <p className="text-sm text-gray-600">{(error as Error).message}</p>
      </div>
    );
  }

  if (isLoading && !jargons) {
    return (
      <div className="mt-10 grid grid-cols-1 gap-6 md:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4">
        {[...Array(PAGE_SIZE)].map((_, i) => (
          <Skeleton key={i} className="h-35 w-full" />
        ))}
      </div>
    );
  }

  return (
    <div className="flex flex-col gap-3">
      <div className="flex items-center justify-between">
        <span className="flex items-center gap-2.5">
          <span className="text-lg font-bold text-gray-900">
            {searchQuery
              ? totalCount > 0
                ? `찾은 전문용어 ${totalCount}개`
                : "찾은 전문용어 없음"
              : `쉬운 전문용어 ${totalCount}개`}
          </span>
          {searchQuery && (
            <div className="flex items-center gap-3">
              <div className="bg-accent flex items-center gap-1 rounded-md py-1 pr-1 pl-2.5">
                <span className="text-sm font-medium">{searchQuery}</span>
                <Button asChild variant="ghost" size="sm" className="size-3">
                  <Link href="/">
                    <X className="size-3" />
                    <span className="sr-only">검색 지우기</span>
                  </Link>
                </Button>
              </div>
            </div>
          )}
        </span>

        {/* Mobile FABs are rendered globally */}
        <DropdownMenu>
          <DropdownMenuTrigger asChild>
            <Button className="hidden transition-all ease-in-out hover:cursor-pointer hover:rounded-3xl sm:inline-flex">
              <SlidersHorizontal />
            </Button>
          </DropdownMenuTrigger>
          <DropdownMenuContent className="w-40" align="end">
            <DropdownMenuLabel>정렬 기준</DropdownMenuLabel>
            <DropdownMenuSeparator />
            <DropdownMenuRadioGroup
              value={sort}
              onValueChange={(value) => handleSortChange(value as SortOption)}
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
      </div>

      {/* Jargon cards grid */}
      {flatData.length > 0 ? (
        <>
          <div className="grid grid-cols-1 gap-6 md:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4">
            {flatData.map((item) => (
              <JargonCard
                key={item.id}
                jargon={{
                  id: item.id,
                  name: item.name,
                  slug: item.slug,
                  translations: item.translations,
                  categories: item.categories,
                  commentCount: item.comment_count,
                  updatedAt: item.updated_at,
                }}
              />
            ))}
          </div>

          {/* Load more button */}
          {hasNextPage && (
            <div className="flex justify-center py-6">
              <Button
                onClick={() => fetchNextPage()}
                disabled={isFetchingNextPage}
                variant="outline"
                size="lg"
              >
                {isFetchingNextPage ? "불러오는 중..." : "더보기"}
              </Button>
            </div>
          )}

          {/* End message */}
          {!hasNextPage && flatData.length > 0 && (
            <div className="flex justify-center py-4">
              <span className="text-sm text-gray-500">
                모든 결과를 불러왔어요
              </span>
            </div>
          )}
        </>
      ) : isLoading ? (
        <div className="flex justify-center py-8">
          <span className="text-gray-500">불러오는 중...</span>
        </div>
      ) : (
        <div className="flex justify-center py-8">
          <span className="text-gray-500">검색 결과가 없어요</span>
        </div>
      )}
    </div>
  );
}
