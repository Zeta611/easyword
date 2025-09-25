"use client";

import { useMemo } from "react";
import TranslationActions from "@/components/jargon/translation-actions";

export type TranslationSortOption = "recent" | "abc" | "zyx";

export interface TranslationListItem {
  id: string;
  name: string;
  author_id: string;
  updated_at?: string;
}

export default function TranslationList({
  translations,
  sort,
}: {
  translations: TranslationListItem[];
  sort: TranslationSortOption;
}) {
  const sorted = useMemo(() => {
    const copy = [...translations];
    if (sort === "recent") {
      copy.sort((a, b) => {
        const aTime = a.updated_at ?? "";
        const bTime = b.updated_at ?? "";
        return bTime.localeCompare(aTime);
      });
    } else if (sort === "abc") {
      copy.sort((a, b) => a.name.localeCompare(b.name, "ko"));
    } else if (sort === "zyx") {
      copy.sort((a, b) => b.name.localeCompare(a.name, "ko"));
    }
    return copy;
  }, [translations, sort]);

  return (
    <ul className="list-disc pl-5">
      {sorted.map((tran) => (
        <li key={tran.id} className="text-foreground flex items-center gap-2">
          <span>{tran.name}</span>
          <TranslationActions
            id={tran.id}
            authorId={tran.author_id}
            name={tran.name}
          />
        </li>
      ))}
    </ul>
  );
}
