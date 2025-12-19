"use client";

import {
  useActionState,
  useCallback,
  useEffect,
  useRef,
  useState,
  startTransition,
} from "react";
import { useRouter } from "next/navigation";
import { SquarePlus } from "lucide-react";
import { useQueryClient } from "@tanstack/react-query";
import Form from "next/form";
import { useFormStatus } from "react-dom";

import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Textarea } from "@/components/ui/textarea";
import {
  Dialog,
  DialogContent,
  DialogDescription,
  DialogFooter,
  DialogHeader,
  DialogTitle,
  DialogTrigger,
} from "@/components/ui/dialog";
import { getClient } from "@/lib/supabase/client";
import { useLoginDialog } from "@/components/auth/login-dialog-provider";
import {
  suggestTranslation,
  type SuggestTranslationState,
} from "@/app/actions/suggest-translation";

function Submit({ label }: { label: string }) {
  const { pending } = useFormStatus();
  return (
    <Button type="submit" disabled={pending}>
      {pending ? "등록 중..." : label}
    </Button>
  );
}

export default function SuggestTranslationDialog({
  jargonId,
}: {
  jargonId: string;
}) {
  const router = useRouter();
  const supabase = getClient();
  const { openLogin } = useLoginDialog();
  const queryClient = useQueryClient();

  const [open, setOpen] = useState(false);

  const formRef = useRef<HTMLFormElement>(null);

  const [result, suggestTranslationAction] = useActionState(
    suggestTranslation,
    {
      ok: false,
      error: "",
    } satisfies SuggestTranslationState,
  );

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

  const resetForm = () => {
    formRef.current?.reset();
  };

  useEffect(() => {
    if (result && result.ok) {
      queryClient.invalidateQueries({ queryKey: ["comments", jargonId] });
      queryClient.invalidateQueries({ queryKey: ["jargons"] }); // To invalidate the jargon list
      startTransition(() => {
        setOpen(false);
      });
      resetForm();
      router.refresh();
    }
  }, [result, router, queryClient, jargonId]);

  return (
    <Dialog open={open} onOpenChange={handleOpenChange}>
      <DialogTrigger asChild>
        <Button
          variant="outline"
          size="sm"
          className="flex items-center gap-1 text-xs"
        >
          <SquarePlus className="-mb-0.5 size-3" />
          쉬운 번역 제안
        </Button>
      </DialogTrigger>
      <DialogContent className="-translate-y-[calc(33dvh)]">
        <DialogHeader>
          <DialogTitle>쉬운 번역 제안하기</DialogTitle>
          <DialogDescription>
            이 전문용어에 대한 쉬운 번역을 제안해볼까요?
          </DialogDescription>
        </DialogHeader>

        <Form
          ref={formRef}
          action={suggestTranslationAction}
          className="flex flex-col gap-3"
        >
          <input type="hidden" name="jargonId" value={jargonId} />

          <div className="flex flex-col gap-1">
            <Label htmlFor="translation" className="text-sm font-medium">
              번역
            </Label>
            <Input
              id="translation"
              type="text"
              name="translation"
              placeholder="덮이"
              required
            />
          </div>

          <div className="flex flex-col gap-1">
            <Label htmlFor="comment" className="text-sm font-medium">
              설명
            </Label>
            <Textarea
              id="comment"
              name="comment"
              placeholder="왜 이 번역이 좋은지 설명해주세요!"
              rows={4}
            />
          </div>

          {result && !result.ok ? (
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
            {/* TODO: Client-side validation */}
            <Submit label="제안하기" />
          </DialogFooter>
        </Form>
      </DialogContent>
    </Dialog>
  );
}
