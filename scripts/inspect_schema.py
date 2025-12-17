from sqlalchemy import create_engine, inspect
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
inspector = inspect(engine)

columns = inspector.get_columns('comment')
for column in columns:
    print(f"Column: {column['name']}, Type: {column['type']}, Nullable: {column['nullable']}")
