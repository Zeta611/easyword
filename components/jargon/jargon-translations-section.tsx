"use client";

import { useState } from "react";
import TranslationList, {
  type TranslationListItem,
  type TranslationSortOption,
} from "@/components/jargon/translation-list";
import JargonActions from "@/components/jargon/jargon-actions";
import TranslationSortButton from "@/components/jargon/translation-sort-button";

export default function JargonTranslationsSection({
  jargonId,
  authorId,
  name,
  translations,
}: {
  jargonId: string;
  authorId: string;
  name: string;
  translations: TranslationListItem[];
}) {
  const [sort, setSort] = useState<TranslationSortOption>("recent");

  return (
    <div className="flex flex-col gap-2">
      <div className="flex items-baseline justify-between gap-2">
        <div className="flex items-baseline gap-2">
          <h1 className="text-2xl font-bold">{name}</h1>
          <JargonActions jargonId={jargonId} authorId={authorId} name={name} />
        </div>
        {translations.length > 0 && (
          <TranslationSortButton value={sort} onChange={setSort} />
        )}
      </div>
      <TranslationList translations={translations} sort={sort} />
    </div>
  );
}
