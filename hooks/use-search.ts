"use client";

import { useMemo, useState } from "react";
import { useQuery } from "@tanstack/react-query";
import { getClient } from "@/lib/supabase/client";
import { QUERIES } from "@/lib/supabase/repository";
import useDebounce from "@/hooks/use-debounce";

export function useSearch(limit = 10) {
  const supabase = getClient();

  const [query, setQuery] = useState("");
  const debouncedQuery = useDebounce(query, 300);

  const { data, isPending, error } = useQuery({
    queryKey: ["search", { q: debouncedQuery, limit }],
    enabled: !!debouncedQuery.trim(),
    queryFn: async ({ signal }) => {
      const [jargonResults, translationResults] = await Promise.all([
        QUERIES.searchJargonNames(supabase, debouncedQuery, limit, { signal }),
        QUERIES.searchTranslationsByName(supabase, debouncedQuery, limit, {
          signal,
        }),
      ]);

      if (jargonResults.error) throw jargonResults.error;
      if (translationResults.error) throw translationResults.error;

      const jargons = jargonResults.data.map((it) => ({
        id: it.id,
        name: it.name,
        type: "jargons",
        jargonId: it.id,
        jargonSlug: it.slug,
      }));
      const translations = translationResults.data.map((it) => ({
        id: it.id,
        name: it.name,
        type: "translations",
        jargonId: it.jargon_id,
        jargonSlug: it.jargon.slug,
      }));
      return { jargons, translations };
    },
  });

  const results = useMemo(() => {
    if (!debouncedQuery.trim()) {
      return { jargons: [], translations: [] };
    }
    return data ?? { jargons: [], translations: [] };
  }, [debouncedQuery, data]);

  return {
    query,
    setQuery,
    results,
    isLoading: debouncedQuery.trim() ? isPending : false,
    error: debouncedQuery.trim() ? error?.message : null,
  };
}
