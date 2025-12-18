"use client";

import { GlobeIcon } from "lucide-react";
import type { ChatStatus, UIMessage } from "ai";
import {
  Conversation,
  ConversationContent,
  ConversationEmptyState,
} from "@/components/ai-elements/conversation";
import {
  Message,
  MessageContent,
  MessageResponse,
} from "@/components/ai-elements/message";
import { Suggestion, Suggestions } from "@/components/ai-elements/suggestion";
import {
  PromptInput,
  PromptInputButton,
  PromptInputFooter,
  PromptInputSubmit,
  PromptInputTextarea,
  PromptInputTools,
} from "@/components/ai-elements/prompt-input";

type ChatAssistantProps = {
  context: "jargon" | "translation";
  messages: UIMessage[];
  status?: ChatStatus;
  error?: Error | null;
  onSendText: (text: string) => void;
  onStop?: () => void;
};

export function createInitialChatAssistantMessages({
  context: _context,
}: {
  context: ChatAssistantProps["context"];
}): UIMessage[] {
  return [];
}

export default function ChatAssistant({
  context,
  messages,
  status,
  error,
  onSendText,
  onStop,
}: ChatAssistantProps) {
  const contextLabel = context === "jargon" ? "용어" : "번역";
  const suggestions =
    context === "jargon"
      ? [
          "새 전문용어 제안을 위한 아이디어를 알려줘",
          "원어/번역/설명 예시를 만들어줘",
          "쉬운 전문용어의 좋은 기준을 알려줘",
        ]
      : [
          "쉬운 번역 후보 2~3개를 제안해줘",
          "각 번역 후보의 장단점을 알려줘",
          "설명 문장 예시를 만들어줘",
        ];
  const isBusy = status === "submitted" || status === "streaming";

  return (
    <div className="flex min-h-[45dvh] flex-col gap-3">
      <div className="text-muted-foreground text-xs">
        쉬운 {contextLabel} 제안을 도와드려요!
      </div>

      <div className="bg-background flex min-h-0 flex-1 flex-col rounded-md border">
        <Conversation className="min-h-0">
          {messages.length === 0 ? (
            <ConversationEmptyState
              title="어떤 도움을 원하시나요?"
              description="아래 버튼을 눌러 시작하거나, 직접 메시지를 입력하세요."
            >
              <div className="flex w-full flex-col items-center gap-2">
                {suggestions.map((suggestion) => (
                  <Suggestion
                    key={suggestion}
                    suggestion={suggestion}
                    className="w-full justify-center"
                    disabled={isBusy}
                    onClick={(text) => onSendText(text)}
                  />
                ))}
              </div>
            </ConversationEmptyState>
          ) : (
            <ConversationContent className="gap-5">
              {messages.map((message) => (
                <Message key={message.id} from={message.role}>
                  <MessageContent>
                    {message.parts
                      .filter((part) => part.type === "text")
                      .map((part, i) => (
                        <MessageResponse key={`${message.id}-${i}`}>
                          {part.text}
                        </MessageResponse>
                      ))}
                  </MessageContent>
                </Message>
              ))}
            </ConversationContent>
          )}
        </Conversation>
      </div>

      {error ? (
        <p className="text-sm text-red-600">
          AI 응답 중 오류가 발생했어요. 잠시 후 다시 시도해주세요.
        </p>
      ) : null}

      <PromptInput
        className={"bg-muted/30"}
        onSubmit={({ text }) => {
          if (isBusy) {
            onStop?.();
            return;
          }
          return onSendText(text);
        }}
      >
        <PromptInputTextarea placeholder="메시지를 입력하세요…" />
        <PromptInputFooter>
          <PromptInputTools>
            <PromptInputButton
              onClick={() => {
                // TODO: Implement logic
              }}
              variant="ghost"
            >
              <GlobeIcon className="size-4" />
              <span>검색</span>
            </PromptInputButton>
          </PromptInputTools>
          <PromptInputSubmit status={status} />
        </PromptInputFooter>
      </PromptInput>
    </div>
  );
}
