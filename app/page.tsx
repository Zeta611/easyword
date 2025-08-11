import { createClient } from "@/lib/supabase/server";
import type { JargonData } from "@/components/jargon/JargonInfiniteList";
import HomePageClient, { SortOption } from "@/components/home/HomePageClient";

interface HomeProps {
  searchParams: Promise<{ q?: string; sort?: string; categories?: string }>;
}

const INITIAL_LOAD_SIZE = 32;

export default async function Home({ searchParams }: HomeProps) {
  const {
    q: searchQueryParam,
    sort: sortParam,
    categories: categoriesParam,
  } = await searchParams;
  const searchQuery = searchQueryParam?.trim() ?? "";
  const sort = sortParam ?? "recent";
  const categories = categoriesParam?.split(",") ?? null;

  const supabase = await createClient();
  // Fetch initial data for SSR
  let initialData: JargonData[] = [];
  let initialTotalCount: number;

  if (searchQuery?.trim()) {
    // Use RPC for search with initial load
    const [jargonResults, countResult] = await Promise.all([
      supabase.rpc("search_jargons", {
        search_query: searchQuery,
        limit_count: INITIAL_LOAD_SIZE,
        offset_count: 0,
        sort_option: sort,
        category_acronyms: categories ?? undefined,
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
      slug: item.slug,
      updated_at: item.updated_at,
      // @ts-expect-error JSON handling
      translations: item.translations.map((t) => t.name),
      // @ts-expect-error JSON handling
      categories: item.categories.map((c) => c.acronym),
      // @ts-expect-error JSON handling
      comment_count: item.comments[0].count,
    }));
    initialTotalCount = countResult.data;
  } else {
    // Fetch all jargons for initial SSR using RPC for consistent sorting
    const [jargonResults, countResult] = await Promise.all([
      supabase.rpc("search_jargons", {
        search_query: "",
        limit_count: INITIAL_LOAD_SIZE,
        offset_count: 0,
        sort_option: sort,
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
      slug: item.slug,
      updated_at: item.updated_at,
      // @ts-expect-error JSON handling
      translations: item.translations.map((t) => t.name),
      // @ts-expect-error JSON handling
      categories: item.categories.map((c) => c.acronym),
      // @ts-expect-error JSON handling
      comment_count: item.comments[0].count,
    }));
    initialTotalCount = countResult.data;
  }

  return (
    <div className="mx-auto flex max-w-7xl flex-col gap-3">
      <HomePageClient
        searchQuery={searchQuery}
        initialData={initialData}
        initialTotalCount={initialTotalCount}
        initialSortCategories={{
          sort: sort as SortOption,
          categories,
        }}
      />
    </div>
  );
}
