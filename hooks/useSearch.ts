"use client";

import { useState, useEffect, useCallback } from "react";
import { createClient } from "@/lib/supabase/client";

export interface SearchResult {
  id: string;
  name: string;
  type: "original" | "translation";
  jargonId: string;
}

export interface GroupedSearchResults {
  original: SearchResult[];
  translation: SearchResult[];
}

export function useSearch() {
  const [query, setQuery] = useState("");
  const [results, setResults] = useState<GroupedSearchResults>({
    original: [],
    translation: [],
  });
  const [isLoading, setIsLoading] = useState(false);
  const [error, setError] = useState<string | null>(null);

  const supabase = createClient();

  const searchJargons = useCallback(
    async (searchQuery: string) => {
      if (!searchQuery.trim()) {
        setResults({ original: [], translation: [] });
        return;
      }

      setIsLoading(true);
      setError(null);

      try {
        // Search in original jargon names
        const { data: jargonResults, error: jargonError } = await supabase
          .from("jargon")
          .select("id, name")
          .ilike("name", `%${searchQuery}%`)
          .limit(10);

        if (jargonError) throw jargonError;

        // Search in translations
        const { data: translationResults, error: translationError } =
          await supabase
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
            .limit(10);

        if (translationError) throw translationError;

        const originalResults: SearchResult[] = (jargonResults || []).map(
          (jargon) => ({
            id: jargon.id,
            name: jargon.name,
            type: "original" as const,
            jargonId: jargon.id,
          }),
        );

        const translationResultsMapped: SearchResult[] = (
          translationResults || []
        ).map((translation) => ({
          id: translation.id,
          name: translation.name,
          type: "translation" as const,
          jargonId: translation.jargon_id,
        }));

        setResults({
          original: originalResults,
          translation: translationResultsMapped,
        });
      } catch (err) {
        console.error("Search error:", err);
        setError("검색 중 오류가 발생했어요");
        setResults({ original: [], translation: [] });
      } finally {
        setIsLoading(false);
      }
    },
    [supabase],
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
