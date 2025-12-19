-- Enable pg_trgm extension for fuzzy matching
create extension if not exists pg_trgm;

-- Add GIN index on translation.name for efficient similarity search
-- Note: Using 'translation' table and 'name' column based on actual schema
create index if not exists idx_translation_name_trgm on translation using gist (name gist_trgm_ops);

-- Create RPC function for similarity search
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
    similarity(t.name, query_text) as similarity
  from
    translation t
  where
    t.name % query_text
    and similarity(t.name, query_text) > threshold
  order by
    similarity desc;
end;
$$;
