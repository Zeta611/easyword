import { createClient } from "@/lib/supabase/server";
import JargonInfiniteList, {
  JargonData,
} from "@/components/JargonInfiniteList";

interface HomeProps {
  searchParams: Promise<{ q?: string }>;
}

const INITIAL_LOAD_SIZE = 32;

export default async function Home({ searchParams }: HomeProps) {
  const { q: searchQuery } = await searchParams;
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
    // Fetch latest jargons for initial SSR
    const result = await supabase
      .from("jargon")
      .select(
        `
          id,
          name,
          updated_at,
          translations:translation(name),
          categories:jargon_category(
            category:category(acronym)
          ),
          comments:comment(count)
          `,
        { count: "exact" },
      )
      .order("updated_at", { ascending: false })
      .limit(INITIAL_LOAD_SIZE);

    if (result.error) throw result.error;

    initialData = result.data.map((jargon) => ({
      id: jargon.id,
      name: jargon.name,
      updated_at: jargon.updated_at,
      translations: jargon.translations.map((t) => t.name),
      categories: jargon.categories.map((c) => c.category.acronym),
      comment_count: jargon.comments[0]?.count || 0,
    }));
    initialTotalCount = result.count || 0;
  }

  return (
    <div className="mx-auto flex max-w-7xl flex-col gap-3">
      <JargonInfiniteList
        searchQuery={searchQuery}
        initialData={initialData}
        initialTotalCount={initialTotalCount}
      />
    </div>
  );
}
