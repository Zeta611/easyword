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
import {
  Tooltip,
  TooltipContent,
  TooltipTrigger,
} from "@/components/ui/tooltip";
import type { TranslationSortOption } from "@/components/jargon/translation-list";

const SYSTEM_PROMPT = `
컴퓨터과학 및 컴퓨터공학 분야의 전문용어를 쉽게 번역하는 것의 취지는 다음과 같아야 한다:
{쉬운 전문용어 배경}
---
너는 컴퓨터 분야의 모든 개념을 완벽하게 파악하고 있는 전문가야.
영문 전문용어를 한국어 쉬운전문용어로 제안한 것들이 다음과 같아.
해당 개념을 가장 잘 전달하는 쉽고 직관적인 순서대로 나열해줘.
기존의 일상적이지 않은 한문투 전문용어는 바람직하지 않아.
대신에 누구나 쉽게 그 개념을 직감할 수 있는 용어들이 바람직한 쉬운전문용어야.
한국어 특성(풍부한 의태어, 의성어, 형용사, 부사)을 활용한 용어나 시적인 표현도 해당 개념을 잘 전달한다면 아무 문제 없어.

순서는 첫 줄에 쉼표로 구분해서 0부터 시작해서 출력해.
용어들을 누락하면 안되고, 모든 단어들을 정렬해야 해.
- 예시 출력: 2,0,1
- 전문용어: {전문용어}
- 쉬운 전문용어 번역 목록: {쉬운 전문용어 번역 목록}
- 댓글 목록: {댓글 목록}
`;

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
          <Tooltip>
            <TooltipTrigger asChild>
              <DropdownMenuRadioItem value="llm" className="cursor-help">
                AI 추천순
              </DropdownMenuRadioItem>
            </TooltipTrigger>
            <TooltipContent className="whitespace-pre-line">
              <p>GPT-5로 정렬했어요. 사용된 명령은 아래와 같아요.</p>
              <pre>{SYSTEM_PROMPT}</pre>
            </TooltipContent>
          </Tooltip>
          <DropdownMenuRadioItem value="recent">
            최근 등록순
          </DropdownMenuRadioItem>
          <DropdownMenuRadioItem value="abc">가나다순</DropdownMenuRadioItem>
          {/* <DropdownMenuRadioItem value="zyx">하파카순</DropdownMenuRadioItem> */}
        </DropdownMenuRadioGroup>
      </DropdownMenuContent>
    </DropdownMenu>
  );
}
