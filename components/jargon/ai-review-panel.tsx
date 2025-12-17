"use client";

import { useState } from "react";
import { Bot, Loader2, CheckCircle2, AlertCircle } from "lucide-react";
import ReactMarkdown from "react-markdown";

import { Button } from "@/components/ui/button";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { ScrollArea } from "@/components/ui/scroll-area";
import { cn } from "@/lib/utils";

interface AIReviewPanelProps {
  term: string;
  translation: string;
}

export function AIReviewPanel({ term, translation }: AIReviewPanelProps) {
  const [loading, setLoading] = useState(false);
  const [review, setReview] = useState<string | null>(null);
  const [error, setError] = useState<string | null>(null);

  const handleReview = async () => {
    if (!translation) return;

    setLoading(true);
    setError(null);
    setReview(null);

    console.log(`[AIReviewPanel] Starting review for term: "${term}", translation: "${translation}"`);

    try {
      const response = await fetch("/api/chat/review", {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
        },
        body: JSON.stringify({
          messages: [
            {
              role: "user",
              content: `Review this translation: Source '${term}', Target '${translation}'`,
            },
          ],
        }),
      });

      if (!response.ok) {
        throw new Error("Failed to fetch review");
      }

      const text = await response.text();
      console.log(`[AIReviewPanel] Review received successfully. Length: ${text.length}`);
      setReview(text);
    } catch (err) {
      console.error("[AIReviewPanel] Error during review:", err);
      setError("AI 검토 중 오류가 발생했습니다.");
    } finally {
      setLoading(false);
    }
  };

  return (
    <div className="space-y-4">
      <div className="flex items-center justify-between">
        <Button
          type="button"
          variant="secondary"
          size="sm"
          onClick={handleReview}
          disabled={loading || !translation}
          className="w-full gap-2"
        >
          {loading ? (
            <Loader2 className="size-4 animate-spin" />
          ) : (
            <Bot className="size-4" />
          )}
          AI 검토 받기
        </Button>
      </div>

      {error && (
        <div className="flex items-center gap-2 text-sm text-red-500">
          <AlertCircle className="size-4" />
          {error}
        </div>
      )}

      {review && (
        <Card className="border-blue-100 bg-blue-50/50 dark:border-blue-900 dark:bg-blue-950/20">
          <CardHeader className="pb-2">
            <CardTitle className="flex items-center gap-2 text-sm font-medium text-blue-700 dark:text-blue-300">
              <Bot className="size-4" />
              AI 리뷰 결과
            </CardTitle>
          </CardHeader>
          <CardContent className="text-sm">
            <ScrollArea className="h-[200px] pr-4">
              <div className="prose prose-sm dark:prose-invert max-w-none">
                <ReactMarkdown>{review}</ReactMarkdown>
              </div>
            </ScrollArea>
          </CardContent>
        </Card>
      )}
    </div>
  );
}
