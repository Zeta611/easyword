-- Fix RPC function return type mismatch
create or replace function search_similar_terms(query_text text, threshold float default 0.3)
returns table (
  id uuid,
  name text,
  similarity float
)
language plpgsql
as $$
begin
  return query
  select
    t.id,
    t.name,
    similarity(t.name, query_text)::float8 as similarity
  from
    translation t
  where
    t.name % query_text
    and similarity(t.name, query_text) > threshold
  order by
    similarity desc;
end;
$$;
