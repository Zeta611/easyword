from sqlalchemy import create_engine, text
from dotenv import load_dotenv
import os

# Load environment variables
load_dotenv('.env.local')
# Fallback to .env if .env.local doesn't have DB params (it usually doesn't, they are in .env or just env vars)
load_dotenv()

USER = os.getenv("user") or "postgres"
PASSWORD = os.getenv("password") or "postgres"
HOST = os.getenv("host") or "localhost"
PORT = os.getenv("port") or "54322"
DBNAME = os.getenv("dbname") or "postgres"

# Construct connection string
# Note: Supabase local dev usually exposes port 54322
DATABASE_URL = f"postgresql+psycopg2://{USER}:{PASSWORD}@{HOST}:{PORT}/{DBNAME}?sslmode=disable"

engine = create_engine(DATABASE_URL)

migration_file = 'supabase/migrations/20251217155000_fix_rpc_return_type.sql'

try:
    with open(migration_file, 'r') as f:
        migration_sql = f.read()

    with engine.connect() as connection:
        print("Applying migration...")
        connection.execute(text(migration_sql))
        connection.commit()
        print("Migration applied successfully.")

except Exception as e:
    print(f"Error applying migration: {e}")
    exit(1)
