CREATE OR REPLACE FUNCTION public.search_jargons(
  search_query text DEFAULT NULL::text,
  sort_option text DEFAULT 'recent'::text,
  limit_count integer DEFAULT 20,
  offset_count integer DEFAULT 0,
  category_acronyms text[] DEFAULT NULL::text[]
) RETURNS TABLE(
  id uuid,
  name text,
  slug text,
  updated_at timestamptz,
  translations json,
  categories json,
  comments json
)
LANGUAGE plpgsql
AS $$
BEGIN
  RETURN QUERY
  ------------------------------------------------------------------
  -- Precompute allowed jargons by category filter
  ------------------------------------------------------------------
  WITH allowed_jargon AS (
    SELECT j.id
    FROM jargon j
    WHERE CASE
      WHEN category_acronyms IS NULL THEN TRUE
      WHEN COALESCE(array_length(category_acronyms, 1), 0) = 0 THEN NOT EXISTS (
        SELECT 1 FROM jargon_category jc WHERE jc.jargon_id = j.id
      )
      ELSE EXISTS (
        SELECT 1
        FROM jargon_category jc
        JOIN category c ON c.id = jc.category_id
        WHERE jc.jargon_id = j.id
          AND c.acronym = ANY (category_acronyms)
      )
    END
  ),

  ------------------------------------------------------------------
  -- 1. jargons matched on their own name
  ------------------------------------------------------------------
  jargon_matches AS (
    SELECT
      j.id,
      j.name,
      j.slug,
      j.updated_at,
      (
        SELECT json_agg(
                 json_build_object('name', t.name)
                 ORDER BY (t.llm_rank IS NULL), t.llm_rank, t.name
               )
        FROM translation t
        WHERE t.jargon_id = j.id
      ) AS translations,
      (
        SELECT json_agg(json_build_object('acronym', c.acronym))
        FROM jargon_category jc
        JOIN category c ON c.id = jc.category_id
        WHERE jc.jargon_id = j.id
      ) AS categories,
      (
        SELECT json_build_array(json_build_object('count', COUNT(*)))
        FROM comment c
        WHERE c.jargon_id = j.id
      ) AS comments
    FROM jargon j
    JOIN allowed_jargon aj ON aj.id = j.id
    WHERE COALESCE(search_query, '') = ''
       OR j.name ILIKE '%' || search_query || '%'
  ),

  ------------------------------------------------------------------
  -- 2. jargons reached through a translation hit
  ------------------------------------------------------------------
  translation_hits AS (
    SELECT DISTINCT j.id
    FROM translation t
    JOIN jargon j ON j.id = t.jargon_id
    JOIN allowed_jargon aj ON aj.id = j.id
    WHERE COALESCE(search_query, '') <> ''
      AND t.name ILIKE '%' || search_query || '%'
  ),
  translation_matches AS (
    SELECT
      j.id,
      j.name,
      j.slug,
      j.updated_at,
      (
        SELECT json_agg(
                 json_build_object('name', t2.name)
                 ORDER BY (t2.llm_rank IS NULL), t2.llm_rank, t2.name
               )
        FROM translation t2
        WHERE t2.jargon_id = j.id
      ) AS translations,
      (
        SELECT json_agg(json_build_object('acronym', c.acronym))
        FROM jargon_category jc
        JOIN category c ON c.id = jc.category_id
        WHERE jc.jargon_id = j.id
      ) AS categories,
      (
        SELECT json_build_array(json_build_object('count', COUNT(*)))
        FROM comment c
        WHERE c.jargon_id = j.id
      ) AS comments
    FROM translation_hits th
    JOIN jargon j ON j.id = th.id
  ),

  ------------------------------------------------------------------
  -- 3. union + final de-duplication
  ------------------------------------------------------------------
  combined AS (
    SELECT * FROM jargon_matches
    UNION ALL
    SELECT * FROM translation_matches
  ),
  final AS (
    SELECT DISTINCT ON (combined.id)
      combined.id,
      combined.name,
      combined.slug,
      combined.updated_at,
      combined.translations,
      combined.categories,
      combined.comments
    FROM combined
    ORDER BY combined.id, combined.updated_at DESC
  )

  ------------------------------------------------------------------
  -- 4. paging with dynamic sorting
  ------------------------------------------------------------------
  SELECT
    f.id,
    f.name,
    f.slug,
    f.updated_at,
    COALESCE(f.translations, '[]'::json)            AS translations,
    COALESCE(f.categories,   '[]'::json)            AS categories,
    COALESCE(f.comments,     '[{"count":0}]'::json) AS comments
  FROM final AS f
  ORDER BY
    CASE WHEN sort_option = 'recent'  THEN f.updated_at END DESC,
    CASE WHEN sort_option = 'popular' THEN (f.comments->0->>'count')::integer END DESC,
    CASE WHEN sort_option = 'abc'     THEN f.name END ASC,
    CASE WHEN sort_option = 'zyx'     THEN f.name END DESC,
    f.updated_at DESC,
    f.id ASC
  LIMIT  limit_count
  OFFSET offset_count;
END;
$$;

NOTIFY pgrst, 'reload schema';
