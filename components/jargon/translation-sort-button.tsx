"use client";

import { SlidersHorizontal } from "lucide-react";
import { Button } from "@/components/ui/button";
import {
  DropdownMenu,
  DropdownMenuContent,
  DropdownMenuLabel,
  DropdownMenuRadioGroup,
  DropdownMenuRadioItem,
  DropdownMenuSeparator,
  DropdownMenuTrigger,
} from "@/components/ui/dropdown-menu";
import type { TranslationSortOption } from "@/components/jargon/translation-list";

export default function TranslationSortButton({
  value,
  onChange,
}: {
  value: TranslationSortOption;
  onChange: (value: TranslationSortOption) => void;
}) {
  return (
    <DropdownMenu>
      <DropdownMenuTrigger asChild>
        <Button
          type="button"
          aria-label="번역 정렬"
          className="size-8.5 transition-all ease-in-out hover:rounded-3xl"
        >
          <SlidersHorizontal />
        </Button>
      </DropdownMenuTrigger>
      <DropdownMenuContent className="w-40" align="end">
        <DropdownMenuLabel>정렬 기준</DropdownMenuLabel>
        <DropdownMenuSeparator />
        <DropdownMenuRadioGroup
          value={value}
          onValueChange={(val) => onChange(val as TranslationSortOption)}
        >
          <DropdownMenuRadioItem value="llm">AI 추천순</DropdownMenuRadioItem>
          <DropdownMenuRadioItem value="recent">
            최근 활동순
          </DropdownMenuRadioItem>
          <DropdownMenuRadioItem value="abc">가나다순</DropdownMenuRadioItem>
          {/* <DropdownMenuRadioItem value="zyx">하파카순</DropdownMenuRadioItem> */}
        </DropdownMenuRadioGroup>
      </DropdownMenuContent>
    </DropdownMenu>
  );
}
