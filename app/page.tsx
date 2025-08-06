import { createClient } from "@/lib/supabase/server";
import JargonCard from "@/components/JargonCard";

export default async function Home() {
  const supabase = await createClient();

  const { data: jargons, error } = await supabase
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
    )
    .order("updated_at", { ascending: false })
    .limit(10);

  // console.debug("Fetched jargons:", jargons);

  if (error) throw error;

  return (
    <div className="mx-auto max-w-7xl">
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
    </div>
  );
}
