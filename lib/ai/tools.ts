import { z } from "zod";
import { tool } from "ai";
import { createClient } from "@/lib/supabase/server";

const lookupDefinitionInputSchema = z.object({
  term: z.string().describe("The technical term to look up"),
  context: z
    .string()
    .optional()
    .describe(
      'The context or domain of the term (e.g. "software engineering", "mathematics")',
    ),
});

type LookupDefinitionInput = z.infer<typeof lookupDefinitionInputSchema>;

type GoogleSearchItem = {
  title?: string;
  snippet?: string;
  link?: string;
};

type GoogleSearchResponse = {
  error?: { message?: string };
  items?: GoogleSearchItem[];
};

export const lookupDefinition = tool({
  description:
    "Search Google for definitions of technical terms. Use this when the source term is ambiguous or highly specialized.",
  inputSchema: lookupDefinitionInputSchema,
  execute: async ({ term, context }: LookupDefinitionInput) => {
    const apiKey = process.env.GOOGLE_SEARCH_API_KEY;
    const cx = process.env.GOOGLE_SEARCH_ENGINE_ID;

    if (!apiKey || !cx) {
      console.warn("Google Search API keys are missing.");
      return { error: "Google Search API is not configured." };
    }

    const query = `define ${term}${context ? ` in ${context}` : ""}`;
    console.log(`[Tool: lookupDefinition] Searching Google for: "${query}"`);
    const url = `https://www.googleapis.com/customsearch/v1?key=${apiKey}&cx=${cx}&q=${encodeURIComponent(query)}&num=3&safe=active`;

    try {
      const response = await fetch(url);
      const data = (await response.json()) as GoogleSearchResponse;

      if (data.error) {
        console.error("Google Search API error:", data.error);
        return { error: data.error.message };
      }

      if (!data.items) {
        return { results: [] };
      }

      const results = data.items.map((item) => ({
        title: item.title,
        snippet: item.snippet,
        link: item.link,
      }));

      console.log(`[Tool: lookupDefinition] Found ${results.length} results.`);
      return { results };
    } catch (error) {
      console.error("Google Search fetch error:", error);
      return { error: "Failed to fetch definitions." };
    }
  },
});

export const checkInternalConsistency = tool({
  description:
    "Check if the term or similar terms exist in the project glossary to ensure consistency.",
  inputSchema: z.object({
    term: z.string().describe("The term to check against the glossary"),
  }),
  execute: async ({ term }: { term: string }) => {
    const supabase = await createClient();

    const { data, error } = await supabase.rpc("search_similar_terms", {
      query_text: term,
      threshold: 0.3,
    });

    console.log(`[Tool: checkInternalConsistency] Checking term: "${term}"`);

    if (error) {
      console.error("Supabase RPC error:", error);
      return { error: error.message };
    }

    const similarTerms = data ?? [];
    console.log(
      `[Tool: checkInternalConsistency] Found ${similarTerms.length} similar terms.`,
    );
    return { similarTerms };
  },
});
