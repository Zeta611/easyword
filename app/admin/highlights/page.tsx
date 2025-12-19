import { redirect } from "next/navigation";
import { createClient } from "@/lib/supabase/server";
import { QUERIES } from "@/lib/supabase/repository";
import HighlightsManager, {
  type FeaturedTranslation,
} from "@/components/admin/highlights-manager";

export default async function AdminHighlightsPage() {
  const supabase = await createClient();

  // Verify admin role
  const {
    data: { user },
  } = await supabase.auth.getUser();
  if (!user || user.app_metadata?.userrole !== "admin") {
    redirect("/");
  }

  const { data, error } = await QUERIES.listAllFeaturedTranslations(supabase);
  if (error) throw error;

  const featuredTranslations: FeaturedTranslation[] = (data ?? []).map(
    (item) => ({
      id: item.id,
      name: item.name,
      featured: item.featured!,
      jargonName: (item.jargon as { name: string })?.name ?? "",
      jargonSlug: (item.jargon as { slug: string })?.slug ?? "",
    }),
  );

  return (
    <div className="mx-auto max-w-3xl py-8">
      <h1 className="mb-6 text-2xl font-bold">하이라이트 관리</h1>
      <p className="text-muted-foreground mb-8">
        홈 화면에 표시될 하이라이트 번역어의 순서를 변경하거나 삭제할 수
        있습니다. 드래그하여 순서를 변경하세요.
      </p>
      <HighlightsManager initialData={featuredTranslations} />
    </div>
  );
}
