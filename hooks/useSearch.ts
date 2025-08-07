"use client";

import { useState, useEffect, useCallback } from "react";
import { createClient } from "@/lib/supabase/client";

export interface SearchResult {
  id: string;
  name: string;
  type: "jargons" | "translations";
  jargonId: string;
}

export interface GroupedSearchResults {
  jargons: SearchResult[];
  translations: SearchResult[];
}

export function useSearch(limit = 10) {
  const [query, setQuery] = useState("");
  const [results, setResults] = useState<GroupedSearchResults>({
    jargons: [],
    translations: [],
  });
  const [isLoading, setIsLoading] = useState(false);
  const [error, setError] = useState<string | null>(null);

  const supabase = createClient();

  const searchJargons = useCallback(
    async (searchQuery: string) => {
      if (!searchQuery.trim()) {
        setResults({ jargons: [], translations: [] });
        return;
      }

      setIsLoading(true);
      setError(null);

      try {
        const [jargonResults, translationResults] = await Promise.all([
          supabase
            .from("jargon")
            .select("id, name")
            .ilike("name", `%${searchQuery}%`)
            .limit(limit),

          supabase
            .from("translation")
            .select(
              `
              id,
              name,
              jargon_id,
              jargon:jargon_id(id, name)
            `,
            )
            .ilike("name", `%${searchQuery}%`)
            .limit(limit),
        ]);

        if (jargonResults.error) throw jargonResults.error;
        if (translationResults.error) throw translationResults.error;

        const jargonResultsMapped: SearchResult[] = (
          jargonResults.data || []
        ).map((jargon) => ({
          id: jargon.id,
          name: jargon.name,
          type: "jargons",
          jargonId: jargon.id,
        }));

        const translationResultsMapped: SearchResult[] = (
          translationResults.data || []
        ).map((translation) => ({
          id: translation.id,
          name: translation.name,
          type: "translations",
          jargonId: translation.jargon_id,
        }));

        setResults({
          jargons: jargonResultsMapped,
          translations: translationResultsMapped,
        });
      } catch (err) {
        console.error("Search error:", err);
        setError("검색 중 오류가 발생했어요");
        setResults({ jargons: [], translations: [] });
      } finally {
        setIsLoading(false);
      }
    },
    [supabase, limit],
  );

  // Debounced search effect
  useEffect(() => {
    const timeoutId = setTimeout(() => {
      searchJargons(query);
    }, 300);

    return () => clearTimeout(timeoutId);
  }, [query, searchJargons]);

  return {
    query,
    setQuery,
    results,
    isLoading,
    error,
  };
}
