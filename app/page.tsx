import { createClient } from "@/lib/supabase/server";
import JargonCard from "@/components/JargonCard";

export default async function Home() {
  const supabase = await createClient();

  const { data: jargons, error } = await supabase
    .from("jargon")
    .select(
      "id, name, created_at, translations:translation(name), categories:jargon_category(category:category(acronym))",
    )
    // .limit(40)
    .order("created_at", { ascending: false });

  console.debug("Fetched jargons:", jargons);

  if (error) throw error;

  return (
    <div className="mx-auto min-h-screen max-w-7xl">
      <div className="grid grid-cols-1 gap-6 md:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4">
        {jargons.map((jargon) => (
          <JargonCard
            key={jargon.id}
            jargon={{
              ...jargon,
              translations: jargon.translations.map((t) => t.name),
              categories: jargon.categories.map((c) => c.category.acronym),
            }}
          />
        ))}
      </div>
    </div>
  );
}
