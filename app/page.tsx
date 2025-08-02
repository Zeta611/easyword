import WordCard, { WordData } from "../components/WordCard";

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

export default function Home() {
  return (
    <div className="mx-auto min-h-screen max-w-7xl">
      <div className="grid grid-cols-1 gap-6 md:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4">
        {sampleWords.map((word) => (
          <WordCard key={word.id} word={word} />
        ))}
      </div>
    </div>
  );
}
