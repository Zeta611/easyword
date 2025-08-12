import { createClient } from "@/lib/supabase/server";
import HomePageClient, { SortOption } from "@/components/home/HomePageClient";
import { DB } from "@/lib/supabase/repository";

const INITIAL_LOAD_SIZE = 32;

export default async function Home({
  searchParams,
}: {
  searchParams: Promise<{ q?: string; sort?: string; categories?: string }>;
}) {
  const {
    q: searchQueryParam,
    sort: sortParam,
    categories: categoriesParam,
  } = await searchParams;
  const searchQuery = searchQueryParam?.trim() ?? "";
  const sort = sortParam ?? "recent";
  const categories = categoriesParam?.split(",") ?? null;

  const supabase = await createClient();

  const [countResult, jargonResults] = await Promise.all([
    DB.countSearchJargons(supabase, searchQuery),
    DB.searchJargons(
      supabase,
      searchQuery,
      INITIAL_LOAD_SIZE,
      0,
      sort,
      categories,
    ),
  ]);

  if (jargonResults.error) throw jargonResults.error;
  if (countResult.error) throw countResult.error;

  const initialData = jargonResults.data.map((item) => ({
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
  const initialTotalCount = countResult.data;

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
