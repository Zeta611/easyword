"use client";

import { GlobeIcon } from "lucide-react";
import { nanoid } from "nanoid";
import type { UIMessage } from "ai";
import {
  Conversation,
  ConversationContent,
} from "@/components/ai-elements/conversation";
import {
  Message,
  MessageContent,
  MessageResponse,
} from "@/components/ai-elements/message";
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
  onSendText: (text: string) => void;
};

export function createInitialChatAssistantMessages(): UIMessage[] {
  return [
    {
      id: nanoid(),
      role: "user",
      parts: [
        {
          type: "text",
          text: "더 쉽게 설명해줄 수 있어?",
        },
      ],
    },
    {
      id: nanoid(),
      role: "assistant",
      parts: [
        {
          type: "text",
          text: "핵심을 잘 파악해서 쉽게 설명해드릴게요.",
        },
      ],
    },
  ];
}

export default function ChatAssistant({
  context,
  messages,
  onSendText,
}: ChatAssistantProps) {
  const contextLabel = context === "jargon" ? "용어" : "번역";

  return (
    <div className="flex min-h-[45dvh] flex-col gap-3">
      <div className="text-muted-foreground text-xs">
        쉬운 {contextLabel} 제안을 도와드려요!
      </div>

      <div className="bg-background flex min-h-0 flex-1 flex-col rounded-md border">
        <Conversation className="min-h-0">
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
        </Conversation>
      </div>

      <PromptInput
        className={"bg-muted/30"}
        onSubmit={({ text }) => onSendText(text)}
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
          <PromptInputSubmit />
        </PromptInputFooter>
      </PromptInput>
    </div>
  );
}
