import {
  streamText,
  convertToModelMessages,
  stepCountIs,
  type UIMessage,
} from "ai";
import { createOpenAI } from "@ai-sdk/openai";
import { lookupDefinition, checkInternalConsistency } from "@/lib/ai/tools";

export const maxDuration = 30;

const solar = createOpenAI({
  apiKey: process.env.SOLAR_API_KEY || process.env.OPENAI_API_KEY || "",
  baseURL: "https://api.upstage.ai/v1",
  fetch: async (input, init) => {
    if (init?.body && typeof init.body === "string") {
      try {
        const payload = JSON.parse(init.body) as {
          messages?: Array<{ role?: string; content?: unknown }>;
        };

        if (Array.isArray(payload.messages)) {
          payload.messages = payload.messages.map((message) =>
            message.role === "developer"
              ? { ...message, role: "system" }
              : message,
          );
          init.body = JSON.stringify(payload);
        }
      } catch {
        // If the body isn't JSON, let the request proceed unchanged.
      }
    }

    return fetch(input, init);
  },
});

const systemPrompt = `You are a Senior Terminologist reviewing technical translations.

Your goal is to validate the translation using the MQM (Multidimensional Quality Metrics) framework.

1. **Accuracy**: Use the 'lookupDefinition' tool to verify the source term's meaning.
2. **Consistency**: Use the 'checkInternalConsistency' tool to check if the target term matches existing glossary entries.
3. **Fluency**: Ensure the target text is grammatically correct in Korean.

If you find issues, categorize them by MQM dimension (Accuracy, Consistency, Fluency, etc.).
If the translation is good, confirm it.

Always use the tools to verify facts. Do not guess.

When you need a tool, use tool-calling only. Do NOT output tool JSON or "action" blocks in the assistant text.`;

export async function POST(req: Request) {
  try {
    const { messages } = (await req.json()) as { messages: UIMessage[] };
    if (!process.env.SOLAR_API_KEY && !process.env.OPENAI_API_KEY) {
      return new Response(
        JSON.stringify({ error: "Missing SOLAR_API_KEY or OPENAI_API_KEY" }),
        { status: 500, headers: { "Content-Type": "application/json" } },
      );
    }

    const result = streamText({
      model: solar.chat("solar-1-mini-chat"),
      system: systemPrompt,
      messages: convertToModelMessages(messages),
      tools: {
        lookupDefinition,
        checkInternalConsistency,
      },
      stopWhen: stepCountIs(5),
    });

    return result.toUIMessageStreamResponse({ originalMessages: messages });
  } catch (error) {
    console.error("Error in route handler:", error);
    return new Response(
      JSON.stringify({
        error: "Internal Server Error",
        details: error instanceof Error ? error.message : String(error),
      }),
      { status: 500 },
    );
  }
}
