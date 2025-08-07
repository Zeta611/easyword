"use client";

import Link from "next/link";
import { SlidersHorizontal, X } from "lucide-react";
import { useCallback, useEffect, useRef, useState } from "react";
import { createClient } from "@/lib/supabase/client";
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

export interface JargonData {
  id: string;
  name: string;
  updated_at: string;
  translations: string[];
  categories: string[];
  comment_count: number;
}

interface JargonInfiniteListProps {
  searchQuery?: string;
  initialData?: JargonData[];
  initialTotalCount?: number;
}

// Custom hook for infinite query with RPC
function useJargonInfiniteQuery(
  searchQuery?: string,
  sortOption: SortOption = "recent",
  initialData?: JargonData[],
  initialTotalCount?: number,
) {
  const [data, setData] = useState<JargonData[]>(initialData || []);
  const [totalCount, setTotalCount] = useState<number | undefined>(
    initialTotalCount,
  );
  if (totalCount !== undefined && data.length > totalCount) {
    console.error(
      `Data length ${data.length} exceeds total count ${totalCount}`,
    );
  }

  // isLoading indicates an initial load w/o data to show
  const [isLoading, setIsLoading] = useState(false);
  // isFetching indicates ongoing fetch for initial/more data
  const [isFetching, setIsFetching] = useState(false);
  const [hasInitialized, setHasInitialized] = useState(!!initialData);

  const [error, setError] = useState<Error | null>(null);
  const prevSearchQuery = useRef(searchQuery);
  const prevSortOption = useRef(sortOption);

  const supabase = createClient();
  const pageSize = 32;

  const fetchNext = useCallback(
    async (offset = data.length, isInitialLoad = false) => {
      if (
        isFetching ||
        (!isInitialLoad &&
          totalCount &&
          data.length >= totalCount) /* no more data to fetch */
      ) {
        return;
      }

      console.debug("Fetching next page with offset:", offset);

      setIsFetching(true);
      if (isInitialLoad) {
        setIsLoading(true);
      }

      try {
        const { data: newData, error } = await supabase.rpc(
          "search_jargons_with_translations",
          {
            search_query: searchQuery || "",
            limit_count: pageSize,
            offset_count: offset,
            sort_option: sortOption,
          },
        );

        if (error) throw error;

        // Fetch total count separately for initial load
        if (offset === 0 || totalCount === undefined) {
          const { data: totalCount, error: countError } = await supabase.rpc(
            "count_search_jargons",
            {
              search_query: searchQuery || "",
            },
          );
          console.debug("Total count fetched:", totalCount);

          if (!countError && totalCount !== undefined) {
            setTotalCount(totalCount);
          }
        }

        // Transform data
        const transformedData = (newData || []).map((item) => ({
          id: item.id,
          name: item.name,
          updated_at: item.updated_at,
          // @ts-expect-error JSON handling
          translations: item.translations.map((t) => t.name),
          // @ts-expect-error JSON handling
          categories: item.categories.map((c) => c.acronym),
          // @ts-expect-error JSON handling
          comment_count: item.comments[0].count,
        }));

        if (offset === 0) {
          // Initial load
          setData(transformedData);
        } else {
          // Append and deduplicate for pagination
          setData((prev) => {
            const existingIds = new Set(prev.map((d) => d.id));
            const uniqueNewData = transformedData.filter(
              (item: JargonData) => !existingIds.has(item.id),
            );
            return [...prev, ...uniqueNewData];
          });
        }

        setError(null);
      } catch (err) {
        console.error("Error fetching jargons:", err);
        setError(err as Error);
      } finally {
        setIsFetching(false);
        setIsLoading(false);
        setHasInitialized(true);
      }
    },
    [data.length, totalCount, searchQuery, sortOption, supabase, isFetching],
  );

  // NOTE: Initial fetch for each query happens here!
  useEffect(() => {
    console.debug(
      "Running useEffect for searchQuery:",
      searchQuery,
      "sortOption:",
      sortOption,
    );
    if (!initialData && !hasInitialized) {
      // No initial data and haven't initialized yet
      console.debug("No initial data, fetching first page");
      fetchNext(0, true);
    } else if (
      prevSearchQuery.current !== searchQuery ||
      prevSortOption.current !== sortOption
    ) {
      // Search query or sort option changed
      console.debug("Query or sort changed");
      prevSearchQuery.current = searchQuery;
      prevSortOption.current = sortOption;
      setData([]);
      setTotalCount(undefined);
      setHasInitialized(false); // will be set to true in fetchNext after load
      fetchNext(0, true);
    }
  }, [searchQuery, sortOption, initialData, hasInitialized, fetchNext]);

  return {
    data,
    totalCount,
    isLoading,
    isFetching,
    error,
    hasMore:
      totalCount === undefined || (totalCount && totalCount > data.length),
    fetchNext,
  };
}

type SortOption = "recent" | "popular" | "abc" | "zyx";

export default function JargonInfiniteList({
  searchQuery,
  initialData,
  initialTotalCount,
}: JargonInfiniteListProps) {
  const [sort, setSort] = useState<SortOption>("recent");

  const { data, totalCount, isLoading, isFetching, hasMore, fetchNext, error } =
    useJargonInfiniteQuery(searchQuery, sort, initialData, initialTotalCount);

  if (error) {
    return (
      <div className="flex flex-col items-center justify-center py-12">
        <p className="text-red-600">오류가 발생했습니다</p>
        <p className="text-sm text-gray-600">{error.message}</p>
      </div>
    );
  }

  return (
    <div className="flex flex-col gap-3">
      <div className="flex items-center justify-between">
        <span className="flex items-center gap-2.5">
          <span className="text-lg font-bold text-gray-900">
            {totalCount !== undefined
              ? searchQuery
                ? totalCount > 0
                  ? `검색 결과 ${totalCount}개`
                  : "검색 결과 없음"
                : `쉬운 전문용어 ${totalCount}개`
              : " "}
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

        <DropdownMenu>
          <DropdownMenuTrigger asChild>
            <Button className="transition-all ease-in-out hover:cursor-pointer hover:rounded-3xl">
              <SlidersHorizontal />
            </Button>
          </DropdownMenuTrigger>
          <DropdownMenuContent className="w-40" align="end">
            <DropdownMenuLabel>정렬 기준</DropdownMenuLabel>
            <DropdownMenuSeparator />
            <DropdownMenuRadioGroup
              value={sort}
              onValueChange={(value) => setSort(value as SortOption)}
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
      {data.length > 0 ? (
        <>
          <div className="grid grid-cols-1 gap-6 md:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4">
            {data.map((item) => (
              <JargonCard
                key={item.id}
                jargon={{
                  id: item.id,
                  name: item.name,
                  translations: item.translations,
                  categories: item.categories,
                  commentCount: item.comment_count,
                  updatedAt: item.updated_at,
                }}
              />
            ))}
          </div>

          {/* Load more button */}
          {hasMore && (
            <div className="flex justify-center py-6">
              <Button
                onClick={() => fetchNext()}
                disabled={isFetching}
                variant="outline"
                size="lg"
              >
                {isFetching ? "불러오는 중..." : "더보기"}
              </Button>
            </div>
          )}

          {/* End message */}
          {!hasMore && data.length > 0 && (
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
