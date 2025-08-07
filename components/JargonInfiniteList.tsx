"use client";

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
  initialCount?: number;
}

// Custom hook for infinite query with RPC
function useJargonInfiniteQuery(
  searchQuery?: string,
  initialData?: JargonData[],
  initialCount?: number,
) {
  const [data, setData] = useState<JargonData[]>(initialData || []);
  const [count, setCount] = useState(initialCount || 0);
  const [isLoading, setIsLoading] = useState(false);
  const [isFetching, setIsFetching] = useState(false);
  const [error, setError] = useState<Error | null>(null);
  const [hasInitialized, setHasInitialized] = useState(!!initialData);
  const prevSearchQuery = useRef(searchQuery);

  const supabase = createClient();
  const pageSize = 20;

  const fetchPage = useCallback(
    async (offset: number, isInitialLoad = false) => {
      if (isFetching) return;

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
        if (offset === 0) {
          const { data: countData, error: countError } = await supabase.rpc(
            "count_search_jargons",
            {
              search_query: searchQuery || "",
            },
          );

          if (!countError && countData !== null) {
            setCount(countData);
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
    [searchQuery, supabase, isFetching],
  );

  const fetchNextPage = useCallback(() => {
    if (!isFetching && count > data.length) {
      fetchPage(data.length);
    }
  }, [data.length, count, isFetching, fetchPage]);

  // Handle search query changes and initial load
  useEffect(() => {
    // New search query
    if (prevSearchQuery.current !== searchQuery) {
      prevSearchQuery.current = searchQuery;
      setData([]);
      setCount(0);
      setHasInitialized(false);
      fetchPage(0, true);
    }
    // If no initial data and haven't initialized yet, fetch
    else if (!initialData && !hasInitialized) {
      fetchPage(0, true);
    }
  }, [searchQuery, initialData, hasInitialized, fetchPage]);

  return {
    data,
    count,
    isLoading,
    isFetching,
    error,
    hasMore: count > data.length,
    fetchNextPage,
  };
}

export default function JargonInfiniteList({
  searchQuery,
  initialData,
  initialCount,
}: JargonInfiniteListProps) {
  const { data, count, isLoading, isFetching, hasMore, fetchNextPage, error } =
    useJargonInfiniteQuery(searchQuery, initialData, initialCount);

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
        <span className="text-lg font-bold text-gray-900">
          {searchQuery
            ? `검색 결과 ${count || 0}개`
            : `쉬운 전문용어 ${count || initialCount || 0}개`}
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
                onClick={fetchNextPage}
                disabled={isFetching}
                variant="outline"
                size="lg"
              >
                {isFetching ? "쉬운 전문용어 불러오는 중..." : "더보기"}
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
          <span className="text-gray-500">표시할 결과가 없어요</span>
        </div>
      )}
    </div>
  );
}
