import Link from "next/link";
import { X } from "lucide-react";
import { createClient } from "@/lib/supabase/server";
import JargonInfiniteList, {
  JargonData,
} from "@/components/JargonInfiniteList";
import { Button } from "@/components/ui/button";

interface HomeProps {
  searchParams: Promise<{ q?: string }>;
}

const INITIAL_LOAD_SIZE = 32;

export default async function Home({ searchParams }: HomeProps) {
  const { q: searchQuery } = await searchParams;
  const supabase = await createClient();

  // Fetch initial data for SSR
  let initialData: JargonData[] = [];
  let totalCount = 0;

  try {
    if (searchQuery?.trim()) {
      // Use RPC for search with initial load
      const { data, error } = await supabase.rpc(
        "search_jargons_with_translations",
        {
          search_query: searchQuery,
          limit_count: INITIAL_LOAD_SIZE,
          offset_count: 0,
        },
      );

      if (!error && data) {
        initialData = data.map((item) => ({
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
      }

      // Get total count
      const { data: countData } = await supabase.rpc("count_search_jargons", {
        search_query: searchQuery,
      });

      totalCount = countData || 0;
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

      if (!result.error && result.data) {
        initialData = result.data.map((jargon) => ({
          id: jargon.id,
          name: jargon.name,
          updated_at: jargon.updated_at,
          translations: jargon.translations.map((t) => t.name),
          categories: jargon.categories.map((c) => c.category.acronym),
          comment_count: jargon.comments[0]?.count || 0,
        }));
        totalCount = result.count || 0;
      }
    }
  } catch (error) {
    console.error("Error fetching initial data:", error);
  }

  return (
    <div className="mx-auto flex max-w-7xl flex-col gap-3">
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

      <JargonInfiniteList
        searchQuery={searchQuery}
        initialData={initialData}
        initialCount={totalCount}
      />
    </div>
  );
}
