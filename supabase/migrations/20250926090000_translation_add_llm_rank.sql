-- Add nullable LLM rank column for offline AI-based sorting
ALTER TABLE public.translation
ADD COLUMN IF NOT EXISTS llm_rank integer;

-- Optional: an index can help if we query/sort by llm_rank often
-- CREATE INDEX IF NOT EXISTS idx_translation_llm_rank ON public.translation (llm_rank);

-- Notify PostgREST to reload schema definitions
NOTIFY pgrst, 'reload schema';
