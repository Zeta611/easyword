import Link from "next/link";
import { createClient } from "@/lib/supabase/server";
import { DB } from "@/lib/supabase/repository";
import CommentThread from "@/components/comment/CommentThread";
import SuggestTranslationDialog from "@/components/dialogs/SuggestTranslationDialog";

export default async function JargonDetailPage({
  params,
}: {
  params: Promise<{ slug: string }>;
}) {
  const { slug } = await params;
  const supabase = await createClient();

  const { data: jargon } = await DB.getJargonBySlug(supabase, slug);

  if (!jargon) {
    return (
      <div className="bg-background flex min-h-[50dvh] items-center justify-center">
        <div className="text-center">
          <h1 className="mb-4 text-2xl font-bold">용어를 찾을 수 없습니다</h1>
          <Link href="/" className="hover:underline">
            홈으로 돌아가기
          </Link>
        </div>
      </div>
    );
  }

  const { data: comments } = await DB.listComments(supabase, jargon.id);

  return (
    <div className="mx-auto flex max-w-4xl flex-col gap-5">
      {/* Jargon details */}
      <div className="bg-card rounded-lg p-3">
        <div className="flex flex-col gap-2">
          {/* categories */}
          {jargon.categories.length > 0 ? (
            <div className="flex flex-wrap gap-2">
              {jargon.categories.map((cat) => (
                <span
                  key={cat.category.acronym}
                  className="bg-background text-foreground border-accent inline-block rounded-full border px-1 py-0.5 font-mono text-sm"
                >
                  {cat.category.acronym}
                </span>
              ))}
            </div>
          ) : null}
          <h1 className="text-2xl font-bold">{jargon.name}</h1>
          {jargon.translations.length > 0 ? (
            <div className="text-foreground text-base">
              <ul className="list-disc pl-5">
                {jargon.translations.map((tran) => (
                  <li key={tran.name} className="text-foreground">
                    {tran.name}
                  </li>
                ))}
              </ul>
            </div>
          ) : (
            <p className="text-muted-foreground text-lg">번역이 없습니다</p>
          )}

          {/* Suggest translation */}
          <SuggestTranslationDialog jargonId={jargon.id} />
        </div>
      </div>

      {/* Comments section */}
      <div className="bg-card rounded-lg p-3">
        <CommentThread jargonId={jargon.id} initialComments={comments ?? []} />
      </div>
    </div>
  );
}
