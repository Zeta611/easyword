import { useFormStatus } from "react-dom";
import { useActionState, useEffect } from "react";
import Form from "next/form";
import { useQueryClient } from "@tanstack/react-query";
import { Button } from "@/components/ui/button";
import { Textarea } from "@/components/ui/textarea";
import {
  createComment,
  CreateCommentAction,
} from "@/app/actions/createComment";

function Submit({ label }: { label: string }) {
  const { pending } = useFormStatus();

  return (
    <Button type="submit" disabled={pending}>
      {pending ? "다는 중..." : label}
    </Button>
  );
}

export default function CommentForm({
  jargonId,
  parentId,
  close,
  placeholder = "여러분의 생각은 어떤가요?",
  submitLabel = "댓글 달기",
}: {
  jargonId: string;
  parentId?: string;
  close?: () => void;
  placeholder?: string;
  submitLabel?: string;
}) {
  const queryClient = useQueryClient();
  const [result, createCommentAction] = useActionState(
    createComment.bind(null, jargonId, parentId ?? null) as CreateCommentAction,
    { ok: false, error: "" },
  );

  useEffect(() => {
    if (result?.ok) {
      queryClient.invalidateQueries({ queryKey: ["comments", jargonId] });
      close?.();
    }
  }, [result?.ok, queryClient, jargonId, close]);

  return (
    <Form action={createCommentAction} className="flex flex-col gap-1.5">
      <div>
        <Textarea
          name="content"
          placeholder={placeholder}
          rows={parentId ? 3 : 4}
        />
        {result?.error && (
          <p className="mt-1 text-sm text-red-600">{result.error}</p>
        )}
      </div>

      <div className="flex justify-end gap-1.5">
        {close && (
          <Button type="button" variant="outline" size="sm" onClick={close}>
            닫기
          </Button>
        )}
        <Submit label={submitLabel} />
      </div>
    </Form>
  );
}
