import { createClient } from "@/lib/supabase/server";
import JargonInfiniteList, {
  JargonData,
} from "@/components/JargonInfiniteList";

interface HomeProps {
  searchParams: Promise<{ q?: string; sort?: string }>;
}

const INITIAL_LOAD_SIZE = 32;

export default async function Home({ searchParams }: HomeProps) {
  const { q: searchQuery, sort: sortParam } = await searchParams;
  const supabase = await createClient();

  // Fetch initial data for SSR
  let initialData: JargonData[] = [];
  let initialTotalCount: number;

  if (searchQuery?.trim()) {
    // Use RPC for search with initial load
    const [jargonResults, countResult] = await Promise.all([
      supabase.rpc("search_jargons_with_translations", {
        search_query: searchQuery,
        limit_count: INITIAL_LOAD_SIZE,
        offset_count: 0,
        sort_option: sortParam || "recent",
      }),

      supabase.rpc("count_search_jargons", {
        search_query: searchQuery,
      }),
    ]);

    if (jargonResults.error) throw jargonResults.error;
    if (countResult.error) throw countResult.error;

    initialData = jargonResults.data.map((item) => ({
      id: item.id,
      name: item.name,
      updated_at: item.updated_at,
      // @ts-expect-error JSON handling
      translations: item.translations.map((t) => t.name),
      // @ts-expect-error JSON handling
      categories: item.categories.map((c) => c.acronym),
      // @ts-expect-error JSON handling
      comment_count: item.comment_count,
    }));
    initialTotalCount = countResult.data;
  } else {
    // Fetch all jargons for initial SSR using RPC for consistent sorting
    const [jargonResults, countResult] = await Promise.all([
      supabase.rpc("search_jargons_with_translations", {
        search_query: "",
        limit_count: INITIAL_LOAD_SIZE,
        offset_count: 0,
        sort_option: sortParam || "recent",
      }),

      supabase.rpc("count_search_jargons", {
        search_query: "",
      }),
    ]);

    if (jargonResults.error) throw jargonResults.error;
    if (countResult.error) throw countResult.error;

    initialData = jargonResults.data.map((item) => ({
      id: item.id,
      name: item.name,
      updated_at: item.updated_at,
      // @ts-expect-error JSON handling
      translations: item.translations.map((t) => t.name),
      // @ts-expect-error JSON handling
      categories: item.categories.map((c) => c.acronym),
      // @ts-expect-error JSON handling
      comment_count: item.comment_count,
    }));
    initialTotalCount = countResult.data;
  }

  return (
    <div className="mx-auto flex max-w-7xl flex-col gap-3">
      <JargonInfiniteList
        searchQuery={searchQuery}
        initialData={initialData}
        initialTotalCount={initialTotalCount}
        initialSort={sortParam}
      />
    </div>
  );
}
