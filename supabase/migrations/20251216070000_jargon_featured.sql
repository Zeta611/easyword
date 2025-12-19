-- Add featured ranking column to jargon + RPC to list featured jargons

ALTER TABLE public.jargon
ADD COLUMN featured integer;

ALTER TABLE public.jargon
ADD CONSTRAINT jargon_featured_positive
CHECK (featured IS NULL OR featured >= 1);

CREATE INDEX jargon_featured_idx
ON public.jargon (featured)
WHERE featured IS NOT NULL;

CREATE OR REPLACE FUNCTION public.list_featured_jargons(
  limit_count integer DEFAULT 8
) RETURNS TABLE(
  id uuid,
  name text,
  slug text,
  updated_at timestamptz,
  translations json,
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
    COALESCE(
      (
        SELECT json_agg(
          json_build_object('name', t.name)
          ORDER BY (t.llm_rank IS NULL), t.llm_rank, t.name
        )
        FROM public.translation t
        WHERE t.jargon_id = j.id
      ),
      '[]'::json
    ) AS translations,
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
  FROM public.jargon j
  WHERE j.featured IS NOT NULL
  ORDER BY j.featured ASC, j.updated_at DESC, j.id ASC
  LIMIT limit_count;
$$;

NOTIFY pgrst, 'reload schema';
