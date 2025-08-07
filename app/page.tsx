import Link from "next/link";
import { X } from "lucide-react";
import { createClient } from "@/lib/supabase/server";
import JargonCard from "@/components/JargonCard";
import { Button } from "@/components/ui/button";

interface JargonResult {
  id: string;
  name: string;
  updated_at: string;
  translations: { name: string }[];
  categories: { category: { acronym: string } }[];
  comments: { count?: number }[];
}

interface HomeProps {
  searchParams: Promise<{ q?: string }>;
}

const SEARCH_LIMIT = 50;

function mergeSortedJargons(
  left: JargonResult[] = [],
  right: JargonResult[] = [],
): JargonResult[] {
  const merged: JargonResult[] = [];
  const seen = new Set<string>();

  let i = 0,
    j = 0;

  while (i < left.length && j < right.length) {
    const pickFromLeft =
      new Date(left[i].updated_at).getTime() >=
      new Date(right[j].updated_at).getTime();

    const candidate = pickFromLeft ? left[i++] : right[j++];

    if (!seen.has(candidate.id)) {
      seen.add(candidate.id);
      merged.push(candidate);
    }
  }

  while (i < left.length) {
    const cand = left[i++];
    if (!seen.has(cand.id)) {
      seen.add(cand.id);
      merged.push(cand);
    }
  }
  while (j < right.length) {
    const cand = right[j++];
    if (!seen.has(cand.id)) {
      seen.add(cand.id);
      merged.push(cand);
    }
  }
  return merged;
}

export default async function Home({ searchParams }: HomeProps) {
  const { q: searchQuery } = await searchParams;
  const supabase = await createClient();

  let jargons, count;

  if (searchQuery?.trim()) {
    // Search mode
    const [jargonResults, translationResults] = await Promise.all([
      supabase
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
        .ilike("name", `%${searchQuery}%`)
        .order("updated_at", { ascending: false })
        .limit(SEARCH_LIMIT),

      supabase
        .from("translation")
        .select(
          `
          jargon:jargon_id(
            id,
            name,
            updated_at,
            translations:translation(name),
            categories:jargon_category(
              category:category(acronym)
            ),
            comments:comment(count)
          )
          `,
        )
        .ilike("name", `%${searchQuery}%`)
        .order("updated_at", { ascending: false })
        .limit(SEARCH_LIMIT),
    ]);

    if (jargonResults.error) throw jargonResults.error;
    if (translationResults.error) throw translationResults.error;

    const combinedJargons = mergeSortedJargons(
      jargonResults.data ?? [],
      translationResults.data?.map((t) => t.jargon) ?? [],
    );

    jargons = combinedJargons;
    count = combinedJargons.length;
  } else {
    // latest jargons
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
      .limit(SEARCH_LIMIT);

    if (result.error) throw result.error;

    jargons = result.data;
    count = result.count;
  }

  // console.debug("Fetched jargons:", jargons);

  return (
    <div className="mx-auto flex max-w-7xl flex-col gap-3">
      <div className="flex flex-col gap-3">
        <div className="flex items-center justify-between">
          <span className="text-lg font-bold text-gray-900">
            {searchQuery && (
              <span className="flex items-center gap-3">
                검색 결과 {count}개
                <div className="bg-accent flex items-center gap-1 rounded-md py-1 pr-1 pl-2.5">
                  <span className="text-sm font-medium">{searchQuery}</span>
                  <Button asChild variant="ghost" size="sm" className="size-3">
                    <Link href="/">
                      <X className="size-3" />
                      <span className="sr-only">검색 지우기</span>
                    </Link>
                  </Button>
                </div>
              </span>
            )}
            {!searchQuery && `쉬운 전문용어 ${count}개`}
          </span>
        </div>
      </div>

      {jargons && jargons.length > 0 ? (
        <div className="grid grid-cols-1 gap-6 md:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4">
          {jargons.map((jargon) => (
            <JargonCard
              key={jargon.id}
              jargon={{
                ...jargon,
                translations: jargon.translations.map((t) => t.name),
                categories: jargon.categories.map((c) => c.category.acronym),
                commentCount: jargon.comments[0]?.count || 0,
                updatedAt: jargon.updated_at,
              }}
            />
          ))}
        </div>
      ) : searchQuery ? (
        <div className="flex flex-col items-center justify-center py-12">
          <p className="mb-2 text-lg font-medium text-gray-900">
            검색 결과가 없습니다
          </p>
          <p className="text-muted-foreground mb-4 text-sm">
            다른 검색어를 시도해보세요
          </p>
          <Button asChild variant="outline">
            <Link href="/">모든 전문용어 보기</Link>
          </Button>
        </div>
      ) : null}
    </div>
  );
}
