"use client";

import Link from "next/link";

export interface WordData {
  id: string;
  term: string;
  translation: string;
  category: string;
}

interface WordCardProps {
  word: WordData;
}

export default function WordCard({ word }: WordCardProps) {
  return (
    <Link href={`/word/${word.id}`}>
      <div className="h-[100%] cursor-pointer rounded-xs bg-white p-6 transition-all duration-200 hover:bg-accent">
        <div className="mb-2">
          <span className="inline-block rounded-full border bg-white px-2 py-1 text-xs text-gray-800">
            {word.category}
          </span>
        </div>
        <h3 className="mb-2 text-lg font-semibold text-gray-900">
          {word.term}
        </h3>
        <p className="text-md mb-2 font-medium text-gray-600">
          {word.translation}
        </p>
      </div>
    </Link>
  );
}
