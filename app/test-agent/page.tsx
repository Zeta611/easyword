"use client";

import { useChat } from "@ai-sdk/react";
import {
  DefaultChatTransport,
  getToolOrDynamicToolName,
  isToolOrDynamicToolUIPart,
} from "ai";
import { useMemo, useState, type FormEvent } from "react";

export default function TestAgentPage() {
  const [input, setInput] = useState("");
  const transport = useMemo(
    () => new DefaultChatTransport({ api: "/api/chat/review" }),
    [],
  );
  const { messages, sendMessage } = useChat({
    transport,
    onFinish: ({ message }) => {
      console.log("Stream finished:", message);
      const toolParts = message.parts.filter(isToolOrDynamicToolUIPart);
      if (toolParts.length > 0) {
        console.log(
          "Tool parts:",
          toolParts.map((part) => ({
            name: getToolOrDynamicToolName(part),
            state: part.state,
          })),
        );
      }
    },
  });

  const handleSubmit = async (event: FormEvent<HTMLFormElement>) => {
    event.preventDefault();
    const trimmed = input.trim();
    if (!trimmed) {
      return;
    }
    await sendMessage({ text: trimmed });
    setInput("");
  };

  return (
    <div className="mx-auto max-w-2xl p-4">
      <h1 className="mb-4 text-2xl font-bold">Agent Test Console</h1>

      {/* Test Scenario Guide */}
      <div className="mt-4 mb-4 text-sm text-gray-600">
        <p>Test Scenario:</p>
        <code
          className="mt-1 block cursor-pointer bg-gray-50 p-2 select-all"
          onClick={(e) => {
            // Optional: Copy to clipboard or auto-fill
            const text =
              "Review this translation: Source 'Idempotency', Target '멱등성'";
            navigator.clipboard.writeText(text);
          }}
        >
          Review this translation: Source 'Idempotency', Target '멱등성'
        </code>
      </div>

      <div className="mb-4 h-96 overflow-auto rounded border border-gray-300 bg-gray-100 p-4 font-mono text-xs whitespace-pre-wrap">
        {JSON.stringify(messages, null, 2)}
      </div>

      <form onSubmit={handleSubmit} className="flex gap-2">
        <input
          className="flex-1 rounded border p-2 text-black"
          value={input}
          onChange={(event) => setInput(event.target.value)}
          placeholder="Type a message..."
        />
        <button
          type="submit"
          className="rounded bg-blue-500 px-4 py-2 text-white hover:bg-blue-600"
        >
          Send
        </button>
      </form>
    </div>
  );
}
