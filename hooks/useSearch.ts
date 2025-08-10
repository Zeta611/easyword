"use client";

import { useMemo, useState } from "react";
import { useQuery } from "@tanstack/react-query";
import { getClient } from "@/lib/supabase/client";
import useDebounce from "@/hooks/useDebounce";

export function useSearch(limit = 10) {
  const supabase = getClient();

  const [query, setQuery] = useState("");
  const debouncedQuery = useDebounce(query, 300);

  const { data, isPending, error } = useQuery({
    queryKey: ["search", { q: debouncedQuery, limit }],
    enabled: !!debouncedQuery.trim(),
    queryFn: async ({ signal }) => {
      let jargonQuery = supabase
        .from("jargon")
        .select("id, name, slug")
        .ilike("name", `%${debouncedQuery}%`)
        .limit(limit);
      let translationQuery = supabase
        .from("translation")
        .select(
          `
          id,
          name,
          jargon_id,
          jargon:jargon_id(id, name, slug)
        `,
        )
        .ilike("name", `%${debouncedQuery}%`)
        .limit(limit);

      if (signal) {
        jargonQuery = jargonQuery.abortSignal(signal);
        translationQuery = translationQuery.abortSignal(signal);
      }

      const [jargonResults, translationResults] = await Promise.all([
        jargonQuery,
        translationQuery,
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
