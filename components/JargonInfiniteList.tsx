"use client";

import Link from "next/link";
import { X } from "lucide-react";
import { useCallback, useEffect, useRef, useState } from "react";
import { createClient } from "@/lib/supabase/client";
import JargonCard from "@/components/JargonCard";
import { Button } from "@/components/ui/button";

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

  const supabase = createClient();
  const pageSize = 20;

  const fetchNext = useCallback(
    async (offset = data.length, isInitialLoad = false) => {
      if (
        isFetching ||
        (totalCount && data.length >= totalCount) /* no more data to fetch */
      )
        return;

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
          console.info("Total count fetched:", totalCount);

          if (!countError && totalCount !== undefined) {
            setTotalCount(totalCount);
          }
        }

        // @ts-nocheck
        const transformedData = (newData || []).map((item) => ({
          id: item.id,
          name: item.name,
          updated_at: item.updated_at,
          // @ts-expect-error JSON handling
          translations: item.translations.map((t) => t.name),
          // @ts-expect-error JSON handling
          categories: item.categories.map((c) => c.acronym),
          // @ts-expect-error JSON handling
          comment_count: item.comments.length,
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
    [data.length, totalCount, searchQuery, supabase, isFetching],
  );

  // NOTE: Initial fetch for each query happens here!
  useEffect(() => {
    if (!initialData && !hasInitialized) {
      // No initial data and haven't initialized yet
      fetchNext(0, true);
    } else if (prevSearchQuery.current !== searchQuery) {
      // New search query
      prevSearchQuery.current = searchQuery;
      setData([]);
      setTotalCount(undefined);
      setHasInitialized(false); // will be set to true in fetchNext after load
      fetchNext(0, true);
    }
  }, [searchQuery, initialData, hasInitialized, fetchNext]);

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

export default function JargonInfiniteList({
  searchQuery,
  initialData,
  initialTotalCount,
}: JargonInfiniteListProps) {
  const { data, totalCount, isLoading, isFetching, hasMore, fetchNext, error } =
    useJargonInfiniteQuery(searchQuery, initialData, initialTotalCount);

  if (error) {
    return (
      <div className="flex flex-col items-center justify-center py-12">
        <p className="text-red-600">오류가 발생했습니다</p>
        <p className="text-sm text-gray-600">{error.message}</p>
      </div>
    );
  }

  console.debug(searchQuery);

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
