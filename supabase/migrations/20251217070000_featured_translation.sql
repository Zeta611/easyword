-- Migrate featured ranking from jargon to translation table
-- Each featured translation will now be marked individually

-- Step 1: Add featured column to translation table
ALTER TABLE public.translation
ADD COLUMN featured integer;

ALTER TABLE public.translation
ADD CONSTRAINT translation_featured_positive
CHECK (featured IS NULL OR featured >= 1);

CREATE INDEX translation_featured_idx
ON public.translation (featured)
WHERE featured IS NOT NULL;

-- Step 2: Migrate existing featured data from jargon to translation
-- For each featured jargon, mark its best translation (by llm_rank) as featured
UPDATE public.translation t
SET featured = j.featured
FROM public.jargon j
WHERE t.jargon_id = j.id
  AND j.featured IS NOT NULL
  AND t.id = (
    SELECT t2.id
    FROM public.translation t2
    WHERE t2.jargon_id = j.id
    ORDER BY (t2.llm_rank IS NULL), t2.llm_rank, t2.name
    LIMIT 1
  );

-- Step 3: Replace list_featured_jargons RPC to query featured translations
-- Must drop first because return type is changing (translations json -> translation text)
DROP FUNCTION IF EXISTS public.list_featured_jargons(integer);

CREATE OR REPLACE FUNCTION public.list_featured_jargons(
  limit_count integer DEFAULT 8
) RETURNS TABLE(
  id uuid,
  name text,
  slug text,
  updated_at timestamptz,
  translation text,
  categories json,
  comments json
)
LANGUAGE sql
STABLE
AS $$
  SELECT
    j.id,
    j.name,
    j.slug,
    j.updated_at,
    t.name AS translation,
    COALESCE(
      (
        SELECT json_agg(json_build_object('acronym', c.acronym))
        FROM public.jargon_category jc
        JOIN public.category c ON c.id = jc.category_id
        WHERE jc.jargon_id = j.id
      ),
      '[]'::json
    ) AS categories,
    COALESCE(
      (
        SELECT json_build_array(json_build_object('count', COUNT(*)))
        FROM public.comment c
        WHERE c.jargon_id = j.id
      ),
      '[{"count":0}]'::json
    ) AS comments
  FROM public.translation t
  JOIN public.jargon j ON j.id = t.jargon_id
  WHERE t.featured IS NOT NULL
  ORDER BY t.featured ASC, j.updated_at DESC, j.id ASC
  LIMIT limit_count;
$$;

-- Step 4: Drop featured column and constraint from jargon table
DROP INDEX IF EXISTS public.jargon_featured_idx;
ALTER TABLE public.jargon DROP CONSTRAINT IF EXISTS jargon_featured_positive;
ALTER TABLE public.jargon DROP COLUMN IF EXISTS featured;

NOTIFY pgrst, 'reload schema';
