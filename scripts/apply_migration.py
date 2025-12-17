from sqlalchemy import create_engine, text
from dotenv import load_dotenv
import os

# Load environment variables
load_dotenv()
USER = os.getenv("user") or "postgres"
PASSWORD = os.getenv("password") or "postgres"
HOST = os.getenv("host") or "localhost"
PORT = os.getenv("port") or "54322"
DBNAME = os.getenv("dbname") or "postgres"

DATABASE_URL = f"postgresql+psycopg2://{USER}:{PASSWORD}@{HOST}:{PORT}/{DBNAME}?sslmode=disable"

engine = create_engine(DATABASE_URL)

migration_sql = """
-- Enable pg_trgm extension for fuzzy matching
create extension if not exists pg_trgm;

-- Add GIN index on translation.name for efficient similarity search
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
"""

with engine.connect() as connection:
    print("Applying migration...")
    connection.execute(text(migration_sql))
    connection.commit()
    print("Migration applied successfully.")
