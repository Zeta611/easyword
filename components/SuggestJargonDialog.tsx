"use client";

import { useCallback, useEffect, useState } from "react";
import { useRouter } from "next/navigation";
import { SquarePlus } from "lucide-react";
import { PostgrestError } from "@supabase/postgrest-js";
import { Textarea } from "./ui/textarea";
import { getClient } from "@/lib/supabase/client";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { MultiSelect } from "@/components/ui/multi-select";
import { Checkbox } from "@/components/ui/checkbox";
import {
  Dialog,
  DialogContent,
  DialogDescription,
  DialogFooter,
  DialogHeader,
  DialogTitle,
  DialogTrigger,
} from "@/components/ui/dialog";
import { eulLeul } from "@/lib/utils";
import { useLoginDialog } from "@/components/LoginDialogProvider";

type CategoryOption = {
  id: number;
  name: string;
  acronym: string;
};

export default function SuggestJargonDialog() {
  const router = useRouter();
  const supabase = getClient();
  const { openLogin } = useLoginDialog();

  const [open, setOpen] = useState(false);
  const [isLoadingCategories, setIsLoadingCategories] = useState(false);
  const [categories, setCategories] = useState<CategoryOption[]>([]);

  const [jargon, setJargon] = useState("");
  const [translation, setTranslation] = useState("");
  const [noTranslation, setNoTranslation] = useState(false);
  const [categoryIds, setCategoryIds] = useState<string[]>([]);
  const [comment, setComment] = useState("");

  const [isSubmitting, setIsSubmitting] = useState(false);
  const [error, setError] = useState<string | null>(null);

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

  useEffect(() => {
    if (!open) return;
    const controller = new AbortController();
    const signal = controller.signal;

    const loadCategories = async () => {
      setIsLoadingCategories(true);
      try {
        const { data, error } = await supabase
          .from("category")
          .select("id, name, acronym")
          .order("acronym", { ascending: true })
          .abortSignal(controller.signal);

        if (error) throw error;
        if (!signal.aborted) setCategories(data);
      } catch (err) {
        if ((err as Error)?.name === "AbortError") return;
        console.error("Failed to load categories", err);
      } finally {
        if (!signal.aborted) setIsLoadingCategories(false);
      }
    };
    loadCategories();

    return () => controller.abort();
  }, [open, supabase]);

  const resetForm = () => {
    setJargon("");
    setTranslation("");
    setNoTranslation(false);
    setCategoryIds([]);
    setComment("");
    setError(null);
  };

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setError(null);

    const trimmedJargon = jargon.trim();
    const trimmedTranslation = translation.trim();
    const trimmedComment =
      comment.trim() ||
      (noTranslation
        ? `${trimmedJargon}의 번역이 필요해요.`
        : `${eulLeul(trimmedTranslation)} 제안해요.`);

    // Only jargon and comment are required; translation/categories optional
    if (!trimmedJargon) {
      setError("용어를 입력해 주세요");
      return;
    }
    if (!trimmedComment) {
      setError("댓글을 입력해 주세요");
      return;
    }
    if (!noTranslation && !trimmedTranslation) {
      setError("번역을 입력하거나 '번역 없이 제안하기'를 선택해 주세요");
      return;
    }

    setIsSubmitting(true);
    try {
      // Optional UX guard; DB function also checks auth (28000)
      const {
        data: { user },
        error: userError,
      } = await supabase.auth.getUser();
      if (userError) throw userError;
      if (!user) {
        setError("로그인해 주세요");
        return;
      }

      const numericCategoryIds = categoryIds.map((cid) => Number(cid));

      const { data, error: rpcError } = await supabase
        .rpc("suggest_jargon", {
          p_name: trimmedJargon,
          p_translation: noTranslation ? "" : trimmedTranslation,
          p_comment: trimmedComment,
          p_category_ids: numericCategoryIds, // [] is fine
        })
        .single();

      if (rpcError) throw rpcError;

      setOpen(false);
      resetForm();
      router.push(`/jargon/${data.jargon_slug}`);
    } catch (err) {
      console.error("Error in handleSubmit", err);
      if (!(err instanceof PostgrestError)) return;

      switch (err.code) {
        case "23505":
          if (
            err.details.includes("jargon_name_key") ||
            err.details.includes("jargon_slug_key")
          ) {
            setError("이미 존재하는 용어예요");
          } else {
            setError("이미 존재하는 값이 있어요");
          }
          break;
        case "23503":
          setError("존재하지 않는 분야가 포함되어 있어요");
          break;
        case "28000":
          setError("로그인이 필요해요");
          break;
        case "22023":
          setError(err.message);
          break;
        default:
          setError(err.message);
          break;
      }
    } finally {
      setIsSubmitting(false);
    }
  };

  return (
    <Dialog open={open} onOpenChange={handleOpenChange}>
      <DialogTrigger asChild>
        <Button
          variant="default"
          size="sm"
          className="text-sm hover:cursor-pointer hover:rounded-3xl hover:text-[10pt]"
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

        <form onSubmit={handleSubmit} className="flex flex-col gap-3">
          <div className="flex flex-col gap-1">
            <Label htmlFor="jargon" className="text-sm font-medium">
              원어
            </Label>
            <Input
              id="jargon"
              type="text"
              value={jargon}
              onChange={(e) => setJargon(e.target.value)}
              placeholder="Coverage"
              disabled={isSubmitting}
              required
            />
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
                  disabled={isSubmitting}
                  onCheckedChange={(checked) => {
                    const isChecked = checked === true;
                    setNoTranslation(isChecked);
                    if (isChecked) {
                      setTranslation("");
                    }
                  }}
                />
                <Label
                  htmlFor="no-translation"
                  className="text-muted-foreground text-xs"
                >
                  번역 없이 제안하기
                </Label>
              </span>
            </div>
            <Input
              id="translation"
              type="text"
              value={translation}
              onChange={(e) => setTranslation(e.target.value)}
              placeholder="덮이"
              disabled={isSubmitting || noTranslation}
            />
          </div>

          <div className="flex flex-col gap-1">
            <Label className="text-sm font-medium">분야</Label>
            <MultiSelect
              variant="outline"
              options={categories.map((c) => ({
                value: String(c.id),
                label: `${c.acronym} (${c.name})`,
                shortLabel: c.acronym,
              }))}
              value={categoryIds}
              onValueChange={setCategoryIds}
              closeOnSelect={true}
              hideSelectAll={true}
              placeholder={isLoadingCategories ? "불러오는 중..." : "분야 선택"}
              disabled={isLoadingCategories || isSubmitting}
              popoverClassName="w-full"
            />
          </div>

          <div className="flex flex-col gap-1">
            <Label htmlFor="comment" className="text-sm font-medium">
              설명
            </Label>
            <Textarea
              id="comment"
              value={comment}
              onChange={(e) => setComment(e.target.value)}
              placeholder="왜 이 용어/번역이 좋은지 설명해주세요!"
              rows={4}
              disabled={isSubmitting}
            />
          </div>

          {error ? <p className="text-sm text-red-600">{error}</p> : null}

          <DialogFooter>
            <Button
              type="button"
              variant="outline"
              onClick={() => {
                setOpen(false);
                resetForm();
              }}
              disabled={isSubmitting}
            >
              닫기
            </Button>
            <Button type="submit" disabled={isSubmitting || !jargon.trim()}>
              {isSubmitting ? "등록 중..." : "제안하기"}
            </Button>
          </DialogFooter>
        </form>
      </DialogContent>
    </Dialog>
  );
}
