import Link from "next/link";
import { createClient } from "@/lib/supabase/server";
import CommentThread from "@/components/CommentThread";
import { Comment } from "@/types/comment";
import SuggestTranslationDialog from "@/components/SuggestTranslationDialog";

interface JargonPageProps {
  params: Promise<{ slug: string }>;
}

export default async function JargonDetailPage({ params }: JargonPageProps) {
  const { slug } = await params;
  const supabase = await createClient();

  // First get the jargon
  const { data: jargon } = await supabase
    .from("jargon")
    .select(
      "id, name, slug, created_at, translations:translation(name), categories:jargon_category(category:category(acronym))",
    )
    .eq("slug", slug)
    .limit(1)
    .single();

  // Then get comments if jargon exists
  let comments: Comment[] = [];
  if (jargon) {
    const { data: commentsData } = await supabase
      .from("comment")
      .select(
        `
      *,
      profile:author_id (
        display_name,
        photo_url
      ),
      translation(name)
    `,
      )
      .eq("jargon_id", jargon.id)
      .order("created_at", { ascending: true });

    comments = (commentsData as Comment[]) || [];
  }

  if (!jargon) {
    return (
      <div className="flex min-h-screen items-center justify-center bg-gray-50">
        <div className="text-center">
          <h1 className="mb-4 text-2xl font-bold text-gray-900">
            용어를 찾을 수 없습니다
          </h1>
          <Link href="/" className="text-blue-600 hover:text-blue-800">
            홈으로 돌아가기
          </Link>
        </div>
      </div>
    );
  }

  return (
    <div className="mx-auto flex max-w-4xl flex-col gap-5">
      {/* Jargon details */}
      <div className="rounded-lg bg-white p-3">
        <div className="flex flex-col gap-2">
          {/* categories */}
          {jargon.categories.length > 0 ? (
            <div className="flex flex-wrap gap-2">
              {jargon.categories.map((cat) => (
                <span
                  key={cat.category.acronym}
                  className="bg-background border-accent inline-block rounded-full border px-1 py-0.5 font-mono text-sm text-gray-800"
                >
                  {cat.category.acronym}
                </span>
              ))}
            </div>
          ) : null}
          <h1 className="text-2xl font-bold">{jargon.name}</h1>
          {jargon.translations.length > 0 ? (
            <div className="text-base text-gray-800">
              <ul className="list-disc pl-5">
                {jargon.translations.map((tran) => (
                  <li key={tran.name} className="text-gray-800">
                    {tran.name}
                  </li>
                ))}
              </ul>
            </div>
          ) : (
            <p className="text-lg text-gray-600">번역이 없습니다</p>
          )}

          {/* Suggest translation */}
          <SuggestTranslationDialog jargonId={jargon.id} />
        </div>
      </div>

      {/* Comments section */}
      <div className="rounded-lg bg-white p-3">
        <CommentThread jargonId={jargon.id} initialComments={comments} />
      </div>
    </div>
  );
}
