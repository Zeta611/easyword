"use client";

import { useState } from "react";
import { useRouter } from "next/navigation";
import { createClient } from "@/lib/supabase/client";
import { Button } from "@/components/ui/button";

interface CommentFormProps {
  jargonId: string;
  parentId?: string;
  onCancel?: () => void;
  onSuccess?: () => void;
  placeholder?: string;
  submitLabel?: string;
}

export default function CommentForm({
  jargonId,
  parentId,
  onCancel,
  onSuccess,
  placeholder = "여러분의 생각은 어떤가요?",
  submitLabel = "댓글 달기",
}: CommentFormProps) {
  const [content, setContent] = useState("");
  const [isSubmitting, setIsSubmitting] = useState(false);
  const [error, setError] = useState<string | null>(null);
  const router = useRouter();
  const supabase = createClient();

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();

    if (!content.trim()) {
      setError("내용을 입력해주세요");
      return;
    }

    setIsSubmitting(true);
    setError(null);

    try {
      // Check if user is authenticated
      const {
        data: { user },
      } = await supabase.auth.getUser();

      if (!user) {
        setError("로그인 후 댓글을 달 수 있어요");
        return;
      }

      const { error: insertError } = await supabase.from("comment").insert({
        content: content.trim(),
        author_id: user.id,
        jargon_id: jargonId,
        parent_id: parentId || null,
      });

      if (insertError) throw insertError;

      // Reset form
      setContent("");

      // Call success callback
      if (onSuccess) {
        onSuccess();
      } else {
        // Refresh page to show new comment
        router.refresh();
      }
    } catch (err) {
      console.error("Error submitting comment:", err);
      setError("댓글 다는 중 문제가 생겼어요");
    } finally {
      setIsSubmitting(false);
    }
  };

  return (
    <form onSubmit={handleSubmit} className="flex flex-col gap-2">
      <div>
        <textarea
          value={content}
          onChange={(e) => setContent(e.target.value)}
          placeholder={placeholder}
          rows={parentId ? 3 : 4}
          className="w-full resize-none rounded-md border border-gray-300 px-3 py-2 text-sm focus:border-blue-500 focus:ring-1 focus:ring-blue-500 focus:outline-none"
          disabled={isSubmitting}
        />
        {error && <p className="mt-1 text-sm text-red-600">{error}</p>}
      </div>

      <div className="flex justify-end gap-2">
        {onCancel && (
          <Button
            type="button"
            variant="outline"
            size="sm"
            onClick={onCancel}
            disabled={isSubmitting}
          >
            닫기
          </Button>
        )}
        <Button
          type="submit"
          size="sm"
          disabled={isSubmitting || !content.trim()}
        >
          {isSubmitting ? "다는 중..." : submitLabel}
        </Button>
      </div>
    </form>
  );
}
