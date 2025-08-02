import Link from "next/link";
import { WordData } from "@/components/WordCard";

const sampleWords: WordData[] = [
  {
    id: "1",
    term: "Algorithm",
    translation: "알고리즘",
    category: "AL",
  },
  {
    id: "2",
    term: "Database",
    translation: "데이터베이스",
    category: "DB",
  },
  {
    id: "3",
    term: "Framework",
    translation: "프레임워크",
    category: "SE",
  },
  {
    id: "4",
    term: "API",
    translation: "프로그램 이음매",
    category: "SE",
  },
  {
    id: "5",
    term: "Programming Language",
    translation: "프로그래밍 언어",
    category: "PL",
  },
  {
    id: "6",
    term: "Machine Learning",
    translation: "기계 학습",
    category: "AI",
  },
  {
    id: "7",
    term: "Blockchain",
    translation: "블록체인",
    category: "SE",
  },
];

interface WordDetailPageProps {
  params: Promise<{ id: string }>;
}

export default async function WordDetailPage({ params }: WordDetailPageProps) {
  const { id } = await params;
  const word = sampleWords.find((w) => w.id === id);

  if (!word) {
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
    <div className="mx-auto max-w-4xl px-4 py-8 sm:px-6 lg:px-8">
      <div className="rounded-lg bg-white p-8 shadow-lg">
        <div className="mb-6">
          <span className="mb-4 inline-block rounded-full bg-accent px-3 py-1 text-sm">
            {word.category}
          </span>
          <h1 className="mb-2 text-3xl font-bold">
            {word.term}
          </h1>
          <h2 className="mb-6 text-2xl font-semibold">
            {word.translation}
          </h2>
        </div>

        <div className="mt-8 border-t border-gray-200 pt-6">
          <h3 className="mb-3 text-lg font-semibold text-gray-900">
            추가 정보
          </h3>
          <div className="grid grid-cols-1 gap-4 md:grid-cols-2">
            <div className="rounded-lg bg-gray-50 p-4">
              <h4 className="mb-2 font-medium text-gray-900">카테고리</h4>
              <p className="text-gray-600">{word.category}</p>
            </div>
            <div className="rounded-lg bg-gray-50 p-4">
              <h4 className="mb-2 font-medium text-gray-900">영문 용어</h4>
              <p className="text-gray-600">{word.term}</p>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
}
