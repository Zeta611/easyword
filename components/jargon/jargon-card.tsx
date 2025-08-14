"use client";

import dayjs from "dayjs";
import relativeTime from "dayjs/plugin/relativeTime";
import "dayjs/locale/ko";
import { MessageCircle } from "lucide-react";
import Link from "next/link";

dayjs.extend(relativeTime);
dayjs.locale("ko");

export interface JargonData {
  id: string;
  name: string;
  slug: string;
  translations: string[];
  categories: string[];
  commentCount: number;
  updatedAt: string;
}

interface JargonCardProps {
  jargon: JargonData;
}

export default function JargonCard({ jargon }: JargonCardProps) {
  return (
    <Link href={`/jargon/${jargon.slug}`}>
      <div className="hover:bg-accent bg-card text-card-foreground flex h-full cursor-pointer flex-col gap-1 rounded-md p-3 transition-all duration-200">
        {/* categories */}
        {jargon.categories.length > 0 ? (
          <div className="flex flex-wrap gap-2">
            {jargon.categories.map((cat) => (
              <span
                key={cat}
                className="bg-background border-accent inline-block rounded-full border px-1 py-0.5 font-mono text-sm"
              >
                {cat}
              </span>
            ))}
          </div>
        ) : null}

        {/* name */}
        <h3 className="text-base font-bold">{jargon.name}</h3>

        {/* translations */}
        <p className="text-base font-normal">
          {jargon.translations.length > 0
            ? jargon.translations.join(", ")
            : "번역이 없어요"}
        </p>

        {/* comment count · last updated */}
        <div className="text-muted-foreground mt-auto flex gap-1 self-end text-sm">
          <span className="flex items-center gap-0.5">
            <MessageCircle className="mb-[-1.5] inline size-3.5" />
            {jargon.commentCount}
          </span>
          ·<span>{dayjs(jargon.updatedAt).fromNow()}</span>
        </div>
      </div>
    </Link>
  );
}
