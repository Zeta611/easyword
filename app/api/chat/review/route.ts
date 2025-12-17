import { createOpenAI } from '@ai-sdk/openai';
import { generateText } from 'ai';
import { lookupDefinition, checkInternalConsistency } from '@/lib/ai/tools';

export const maxDuration = 30;

const solar = createOpenAI({
  apiKey: process.env.SOLAR_API_KEY || process.env.OPENAI_API_KEY,
  baseURL: 'https://api.upstage.ai/v1/solar',
});

async function callSolar(messages: any[], tools: any[]) {
  console.log('[LLM] Sending request to Solar API...');
  const response = await fetch('https://api.upstage.ai/v1/solar/chat/completions', {
    method: 'POST',
    headers: {
      'Authorization': `Bearer ${process.env.SOLAR_API_KEY}`,
      'Content-Type': 'application/json',
    },
    body: JSON.stringify({
      model: 'solar-1-mini-chat',
      messages,
      tools,
      tool_choice: 'auto',
      stream: false,
    }),
  });

  if (!response.ok) {
    const text = await response.text();
    throw new Error(`Solar API error: ${response.status} ${text}`);
  }

  const data = await response.json();
  console.log('[LLM] Received response from Solar API.');
  return data;
}

export async function POST(req: Request) {
  try {
    const { messages } = await req.json();
    
    // Define tools schema for Solar (OpenAI compatible)
    const tools = [
      {
        type: 'function',
        function: {
          name: 'lookupDefinition',
          description: 'Search Google for definitions of technical terms.',
          parameters: {
            type: 'object',
            properties: {
              term: { type: 'string', description: 'The technical term to look up' },
              context: { type: 'string', description: 'The context or domain' },
            },
            required: ['term'],
          },
        },
      },
      {
        type: 'function',
        function: {
          name: 'checkInternalConsistency',
          description: 'Check if the term exists in the project glossary.',
          parameters: {
            type: 'object',
            properties: {
              term: { type: 'string', description: 'The term to check' },
            },
            required: ['term'],
          },
        },
      },
    ];

    let currentMessages = [...messages];
    // Add system message if not present
    if (currentMessages[0].role !== 'system') {
      currentMessages.unshift({
        role: 'system',
        content: `You are a Senior Terminologist reviewing technical translations.
        
        Your goal is to validate the translation using the MQM (Multidimensional Quality Metrics) framework.
        
        1. **Accuracy**: Use the 'lookupDefinition' tool to verify the source term's meaning.
        2. **Consistency**: Use the 'checkInternalConsistency' tool to check if the target term matches existing glossary entries.
        3. **Fluency**: Ensure the target text is grammatically correct in Korean.
        
        If you find issues, categorize them by MQM dimension (Accuracy, Consistency, Fluency, etc.).
        If the translation is good, confirm it.
        
        Always use the tools to verify facts. Do not guess.`
      });
    }

    let steps = 0;
    const maxSteps = 5;

    while (steps < maxSteps) {
      steps++;
      const data = await callSolar(currentMessages, tools);
      const choice = data.choices[0];
      const message = choice.message;

      currentMessages.push(message);

      if (message.tool_calls) {
        console.log('Tool calls:', JSON.stringify(message.tool_calls, null, 2));
        
        for (const toolCall of message.tool_calls) {
          const { name, arguments: argsString } = toolCall.function;
          const args = JSON.parse(argsString);
          let result;

          if (name === 'lookupDefinition' && lookupDefinition.execute) {
            result = await lookupDefinition.execute(args, { toolCallId: toolCall.id, messages: [] });
          } else if (name === 'checkInternalConsistency' && checkInternalConsistency.execute) {
            result = await checkInternalConsistency.execute(args, { toolCallId: toolCall.id, messages: [] });
          }

          currentMessages.push({
            role: 'tool',
            tool_call_id: toolCall.id,
            content: JSON.stringify(result),
          });
        }
      } else {
        // Final response
        return new Response(message.content);
      }
    }

    return new Response("Max steps reached without final response.");

  } catch (error) {
    console.error('Error in route handler:', error);
    return new Response(JSON.stringify({ error: 'Internal Server Error', details: error instanceof Error ? error.message : String(error) }), { status: 500 });
  }
}
