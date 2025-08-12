"use client";

import {
  useActionState,
  useCallback,
  useEffect,
  useRef,
  useState,
} from "react";
import { useRouter } from "next/navigation";
import { SquarePlus } from "lucide-react";
import { useQuery, useQueryClient } from "@tanstack/react-query";
import Form from "next/form";
import { useFormStatus } from "react-dom";
import { Textarea } from "@/components/ui/textarea";
import { getClient } from "@/lib/supabase/client";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { MultiSelect } from "@/components/ui/multi-select";
import { Checkbox } from "@/components/ui/checkbox";
import { QUERIES } from "@/lib/supabase/repository";
import {
  Dialog,
  DialogContent,
  DialogDescription,
  DialogFooter,
  DialogHeader,
  DialogTitle,
  DialogTrigger,
} from "@/components/ui/dialog";
import { useLoginDialog } from "@/components/auth/LoginDialogProvider";
import {
  suggestJargon,
  type SuggestJargonState,
} from "@/app/actions/suggestJargon";

function Submit({ label }: { label: string }) {
  const { pending } = useFormStatus();
  return (
    <Button type="submit" disabled={pending}>
      {pending ? "등록 중..." : label}
    </Button>
  );
}

export default function SuggestJargonDialog() {
  const router = useRouter();
  const supabase = getClient();
  const { openLogin } = useLoginDialog();
  const queryClient = useQueryClient();

  const [open, setOpen] = useState(false);

  const formRef = useRef<HTMLFormElement>(null);

  const [noTranslation, setNoTranslation] = useState(false);
  const [categoryIds, setCategoryIds] = useState<string[]>([]);

  const [result, suggestJargonAction] = useActionState(suggestJargon, {
    ok: false,
    error: "",
  } satisfies SuggestJargonState);

  const handleOpenChange = useCallback(
    async (nextOpen: boolean) => {
      if (nextOpen) {
        const {
          data: { user },
        } = await supabase.auth.getUser();
        if (!user) {
          openLogin();
          return;
        }
      }
      setOpen(nextOpen);
    },
    [openLogin, supabase],
  );

  const { data: categories, isLoading: isLoadingCategories } = useQuery({
    queryKey: ["categories"],
    enabled: open,
    queryFn: async ({ signal }) => {
      const { data, error } = await QUERIES.listCategories(supabase, {
        signal,
      });
      if (error) throw error;
      return data;
    },
  });

  const resetForm = () => {
    setNoTranslation(false);
    setCategoryIds([]);
    formRef.current?.reset();
  };

  useEffect(() => {
    if (result && result.ok && "jargonSlug" in result) {
      queryClient.invalidateQueries({ queryKey: ["jargons"] });
      queryClient.invalidateQueries({ queryKey: ["jargons-count"] });
      setOpen(false);
      resetForm();
      router.push(`/jargon/${result.jargonSlug}`);
    }
  }, [result, router, queryClient]);

  return (
    <Dialog open={open} onOpenChange={handleOpenChange}>
      <DialogTrigger asChild>
        <Button
          variant="default"
          size="sm"
          className="text-sm hover:rounded-3xl hover:text-[10pt]"
        >
          <SquarePlus className="-mb-0.5 size-4" />
          용어제안
        </Button>
      </DialogTrigger>
      <DialogContent className="-translate-y-[calc(33dvh)]">
        <DialogHeader>
          <DialogTitle>쉬운 전문용어 제안하기</DialogTitle>
          <DialogDescription>
            쉬운 전문용어를 새로 제안해볼까요?
          </DialogDescription>
        </DialogHeader>

        <Form
          ref={formRef}
          action={suggestJargonAction}
          className="flex flex-col gap-3"
        >
          <div className="flex flex-col gap-1">
            <Label htmlFor="jargon" className="text-sm font-medium">
              원어
            </Label>
            <Input
              id="jargon"
              type="text"
              name="jargon"
              placeholder="coverage"
              required
            />
            <p className="text-muted-foreground text-xs">
              대문자가 고유명사의 일부로 사용되는 경우 외에는 소문자를
              사용해주세요
            </p>
          </div>

          <div className="flex flex-col gap-1">
            <div className="flex items-center justify-between">
              <Label htmlFor="translation" className="text-sm font-medium">
                번역
              </Label>
              <span className="flex items-center gap-1">
                <Checkbox
                  id="no-translation"
                  checked={noTranslation}
                  onCheckedChange={(checked) =>
                    setNoTranslation(checked === true)
                  }
                />
                <Label
                  htmlFor="no-translation"
                  className="text-muted-foreground text-xs"
                >
                  번역 없이 제안하기
                </Label>
              </span>
            </div>
            <input
              type="hidden"
              name="noTranslation"
              value={noTranslation ? "true" : "false"}
            />
            <Input
              id="translation"
              type="text"
              name="translation"
              placeholder="덮이"
              disabled={noTranslation}
            />
          </div>

          <div className="flex flex-col gap-1">
            <Label className="text-sm font-medium">분야</Label>
            <MultiSelect
              variant="outline"
              options={(categories ?? []).map((c) => ({
                value: String(c.id),
                label: `${c.acronym} (${c.name})`,
                shortLabel: c.acronym,
              }))}
              value={categoryIds}
              onValueChange={setCategoryIds}
              closeOnSelect={true}
              hideSelectAll={true}
              placeholder={isLoadingCategories ? "불러오는 중..." : "분야 선택"}
              disabled={isLoadingCategories}
              popoverClassName="w-full"
            />
            {categoryIds.map((cid) => (
              <input key={cid} type="hidden" name="categoryIds" value={cid} />
            ))}
          </div>

          <div className="flex flex-col gap-1">
            <Label htmlFor="comment" className="text-sm font-medium">
              설명
            </Label>
            <Textarea
              id="comment"
              name="comment"
              placeholder="왜 이 용어/번역이 좋은지 설명해주세요!"
              rows={4}
            />
          </div>

          {result && !("jargonSlug" in result) && !result.ok ? (
            <p className="text-sm text-red-600">{result.error}</p>
          ) : null}

          <DialogFooter>
            <Button
              type="button"
              variant="outline"
              onClick={() => {
                setOpen(false);
                resetForm();
              }}
            >
              닫기
            </Button>
            {/* TODO: Perform client-side validation and disable if not ok */}
            <Submit label="제안하기" />
          </DialogFooter>
        </Form>
      </DialogContent>
    </Dialog>
  );
}
