"use client";

import Link from "next/link";

export interface JargonData {
  id: string;
  name: string;
  translations: string[];
  categories: string[];
}

interface JargonCardProps {
  jargon: JargonData;
}

export default function JargonCard({ jargon }: JargonCardProps) {
  return (
    <Link href={`/jargon/${jargon.id}`}>
      <div className="hover:bg-accent flex h-full cursor-pointer flex-col gap-1 rounded-md bg-white p-3.5 transition-all duration-200">
        {/* categories */}
        {jargon.categories.length > 0 ? (
          <div className="flex flex-wrap gap-2">
            {jargon.categories.map((cat) => (
              <span
                key={cat}
                className="bg-background border-accent inline-block rounded-full border px-1 py-0.5 font-mono text-sm text-gray-800"
              >
                {cat}
              </span>
            ))}
          </div>
        ) : null}

        {/* name */}
        <h3 className="text-base font-bold">{jargon.name}</h3>

        {/* translations */}
        <p className="text-base font-normal text-gray-800">
          {jargon.translations.length > 0
            ? jargon.translations.join(", ")
            : "No translations available"}
        </p>
      </div>
    </Link>
  );
}
